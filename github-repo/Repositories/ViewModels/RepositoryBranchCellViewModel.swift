//
//  RepositoryBranchCellViewModel.swift
//  github-repo
//
//  Created by Michael Michael on 15.06.22.
//

import Foundation

class RepositoryBranchCellViewModel {
    
    @Published var branch: RepositoryBranch
    
    init(branch: RepositoryBranch) {
        self.branch = branch
    }
}
