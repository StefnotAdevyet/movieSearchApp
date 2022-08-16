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
    }
    @IBOutlet weak var searchTable: UITableView!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        search()
        viewModel.delegate = self
    }
    

    func configureTableView() {
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    
    func search() {
        viewModel.fetch()
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.getTitle(at: indexPath.row)
        return cell
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

