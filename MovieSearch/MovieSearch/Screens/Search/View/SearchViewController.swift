//
//  ViewController.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func searchBtn(_ sender: UIButton) {
        search()
    }
    @IBOutlet weak var searchTable: UITableView!
    
    lazy var viewModel = {
        SearchViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        searchBar.delegate = self
        initViewModel()
    }
    func initViewModel() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.searchTable.reloadData()
            }
        }
    }
    func configureTableView() {
        searchTable.delegate = self
        searchTable.dataSource = self
        searchTable.register(SearchTableCell.nib, forCellReuseIdentifier: SearchTableCell.id)
    }
    
    
    func setViewModel() {
        //I think I still need this?
    }
    
    
    func search() {
        guard let searchTerm = searchBar.text else {
            return
        }
        viewModel.getMovies(movie: searchTerm)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
        searchBar.resignFirstResponder()
    }
}

//functions for the tableView
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchCellViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTable.dequeueReusableCell(withIdentifier: SearchTableCell.id, for: indexPath) as? SearchTableCell else {
            fatalError("xib does not exist")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.searchCellViewModel = cellVM
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate to a detailView of the specified row
    }
}

//functions to update table and rows
extension SearchViewController: UpdateTable {
    func reloadTable() {
        DispatchQueue.main.async {
            self.searchTable.reloadData()
        }
    }
    func reloadTable(at: Int) {
        DispatchQueue.main.async {
            self.searchTable.reloadRows(at: [IndexPath(row: at, section: 0)], with: .automatic)
        }
    }
}

