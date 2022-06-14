//
//  RepositoryDetailViewController.swift
//  github-repo
//
//  Created by Michael Michael on 14.06.22.
//

import UIKit
import Combine

class RepositoryBranchViewController: BaseViewController {
    
    let cellIdentifier = "repo_branch_cell"
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var repository: RepositorySearchResponse.Repository?
    
    private var viewModel: RepositoryBranchViewModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    convenience init(viewModel: RepositoryBranchViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
        guard let viewModel = viewModel else {
            return
        }

        viewModel.$cellViewModels
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func setupTableView() {
        
        self.tableView.register(UINib(nibName: "RepositoryBranchCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension RepositoryBranchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let viewModel = self.viewModel else { return 0 }
        
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RepositoryBranchCell,
              let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        
        cell.bind(viewModel: viewModel.cellViewModels[indexPath.row])
        
        return cell
    }
}

extension RepositoryBranchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
