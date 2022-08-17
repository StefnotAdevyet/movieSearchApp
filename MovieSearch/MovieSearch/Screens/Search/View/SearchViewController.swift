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
    
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        searchBar.delegate = self
        viewModel.delegate = self
    }
    
    
    func configureTableView() {
        searchTable.delegate = self
        searchTable.dataSource = self
        searchTable.register(SearchTableCell.nib, forCellReuseIdentifier: SearchTableCell.id)
    }
    
    func setViewModel() {
        
    }
    
    func search() {
        guard let searchTerm = searchBar.text else {
            return
        }
        viewModel.fetch(str: searchTerm)
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
        0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTable.dequeueReusableCell(withIdentifier: SearchTableCell.id, for: indexPath)
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.id) as? DetailViewController {
            vc.configure(title: viewModel.getTitle(at: indexPath.row))
            present(vc, animated: true)
        } else {
            print("error creating ViewController")
        }
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

