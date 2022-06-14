//
//  RepositoryBranchCell.swift
//  github-repo
//
//  Created by Michael Michael on 15.06.22.
//

import UIKit
import Combine

class RepositoryBranchCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    
    func bind(viewModel: RepositoryBranchCellViewModel) {
        
        self.label.text =  viewModel.branch.name
    }
}
