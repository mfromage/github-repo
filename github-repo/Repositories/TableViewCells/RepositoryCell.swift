//
//  RepositoryCell.swift
//  github-repo
//
//  Created by Michael Michael on 15.06.22.
//

import UIKit
import Combine

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var lblRepositoryName: UILabel!
    
    @IBOutlet weak var lblBranchCount: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    
    func bind(viewModel: RepositoryCellViewModel) {
        
        self.lblRepositoryName.text =  viewModel.item.fullName
       
        viewModel.$branches
            .receive(on: RunLoop.main)
            .map({ $0.count })
            .sink { [weak self] value in
                
                self?.lblBranchCount.text = "\(value)"
            }
            .store(in: &cancellables)
    }
    
    
}
