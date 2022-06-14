//
//  RepositoryNetworkModel.swift
//  github-repo
//
//  Created by Michael Michael on 14.06.22.
//

import Foundation
import Combine

class RepositoryNetworkModel {
    
    let baseUrl = "https://api.github.com"
    
    let token = "[GITHUB_ACCESS_TOKEN]"
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
    func searchRepository(keyword: String) -> AnyPublisher<RepositorySearchResponse, NetworkError> {
        
        let urlStr = "\(baseUrl)/search/repositories?q=\(keyword)"
        guard let url = URL(string: urlStr) else {
            return Fail(error: .invalidUrl).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: makeRequest(url))
            .mapError { error in
                .errorResponse(message: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decodeJson(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getRepositoryBranch(repositoryName: String) -> AnyPublisher<[RepositoryBranch], NetworkError> {
        
        let urlStr = "\(baseUrl)/repos/\(repositoryName)/branches"
        guard let url = URL(string: urlStr) else {
            return Fail(error: .invalidUrl).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: makeRequest(url))
            .mapError { error in
                .errorResponse(message: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decodeJson(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    private func makeRequest(_ url: URL) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    private func decodeJson<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                .errorResponse(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }

}
