//
//  RepositoryCellViewModel.swift
//  github-repo
//
//  Created by Michael Michael on 14.06.22.
//

import Foundation
import Combine

class RepositoryCellViewModel {
    
    @Published var item: RepositorySearchResponse.Repository
    
    @Published var branches: [RepositoryBranch] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private var networkModel: RepositoryNetworkModel = RepositoryNetworkModel()
    
    init(item: RepositorySearchResponse.Repository) {
        self.item = item
        
        getRepositoryBranches(repositoryName: item.fullName)
    }
    
    func getRepositoryBranches(repositoryName: String) {
        
        networkModel.getRepositoryBranch(repositoryName: repositoryName)
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                
                guard let self = self else { return }
                switch value{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.branches = []
                case .finished:
                    break
                }
                
            } receiveValue: { [weak self] value in
                
                guard let self = self else { return }
                
                self.branches = value
            }
            .store(in: &cancellables)
    }
}
