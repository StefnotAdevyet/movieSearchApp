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
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.getTitle(at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.id) as? DetailViewController {
            vc.imgSrc = viewModel.getImg(at: indexPath.row)
            vc.titleLabel?.text = viewModel.getTitle(at: indexPath.row)
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

