//
//  RepositorySearchViewController.swift
//  github-repo
//
//  Created by Michael Michael on 14.06.22.
//

import UIKit
import Combine

class RepositorySearchViewController: BaseViewController {
    
    let cellIdentifier = "repo_cell"
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: RepositorySearchViewModel?
    
    @Published var keyword: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    convenience init(viewModel: RepositorySearchViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search Repository"
        
        self.setupTableView()
        self.setupSearchbar()
        
        self.bindViewModel()
    }
    
    func setupTableView() {
        
        self.tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupSearchbar() {
        
        self.searchBar.delegate = self
    }
    
    func bindViewModel() {
        
        $keyword.receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.viewModel?.keyword = value
            }
            .store(in: &cancellables)
        
        self.viewModel?.$cellViewModels
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
            
    }
    
    func navigateToDetail(branches: [RepositoryBranch]) {
        
        let detailVC = RepositoryBranchViewController(viewModel: .init(branches: branches))
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension RepositorySearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let viewModel = self.viewModel else { return 0 }
        
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RepositoryCell,
              let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        
        cell.bind(viewModel: viewModel.cellViewModels[indexPath.row])
        
        return cell
    }
}

extension RepositorySearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let branches = self.viewModel?.cellViewModels[indexPath.row].branches ?? []
        self.navigateToDetail(branches: branches)
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyword = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
