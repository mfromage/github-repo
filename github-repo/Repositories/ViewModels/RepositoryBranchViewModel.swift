//
//  RepositoryBranchViewModel.swift
//  github-repo
//
//  Created by Michael Michael on 15.06.22.
//

import Foundation
import Combine

class RepositoryBranchViewModel {
    
    @Published var cellViewModels: [RepositoryBranchCellViewModel] = []
    
    init(branches: [RepositoryBranch]) {
        self.cellViewModels = branches.map(RepositoryBranchCellViewModel.init)
    }
}
