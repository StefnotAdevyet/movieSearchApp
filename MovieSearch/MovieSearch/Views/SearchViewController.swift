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
    
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTable.delegate = self
        searchTable.dataSource = self
        // Do any additional setup after loading the view.
        Network().getMovies(searchTerm: "star wars") { movies in
            self.movies = movies
        }
    }


}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = movies[indexPath.row].original_title
        return cell
    }
    
    
}

