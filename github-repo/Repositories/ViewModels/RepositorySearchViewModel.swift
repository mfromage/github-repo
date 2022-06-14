//
//  RepositorySearchViewModel.swift
//  github-repo
//
//  Created by Michael Michael on 14.06.22.
//

import Foundation
import Combine

class RepositorySearchViewModel {
    
    @Published var keyword: String = ""
    
    @Published var cellViewModels: [RepositoryCellViewModel] = []
    
    private let networkModel: RepositoryNetworkModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        networkModel = RepositoryNetworkModel()
        setupBindings()
    }
    
    func setupBindings() {
        $keyword
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                
                self?.searchRepository()
                
            }.store(in: &cancellables)
    }
    
    func searchRepository() {
        print(keyword)
        
        guard !keyword.isEmpty else {
            return
        }
        
        networkModel.searchRepository(keyword: keyword)
            .map({ $0.items.map(RepositoryCellViewModel.init) })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                switch value{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.cellViewModels = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.cellViewModels = Array(value.prefix(10))
            }
            .store(in: &cancellables)
    }
}
