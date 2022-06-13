//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTxt: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.sync {
                moviesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(nib, forCellReuseIdentifier: "MovieCell")
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = 600
        searchBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let searchTerm = searchTxt.text else {
            print("type movie title")
            return
        }
        print(searchTerm)
        search(searchTerm: searchTerm)
        }
    
    func search(searchTerm: String) {
        Network().getMovies(searchTerm: searchTerm) { movies in
            self.movies = movies
        }
        print("searched for movies")
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.configure(movie: movies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let posterPath = movie.poster_path ?? ""
        let imgUrl = Network().baseImgUrl + posterPath
        let storyBoard : UIStoryboard = UIStoryboard(name: "MovieDetail", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailViewController
        
        nextViewController.movieTitle = movie.original_title
        nextViewController.releaseDate = movie.release_date
        nextViewController.descriptionText = movie.overview
        nextViewController.imgPath = imgUrl

        navigationController?.show(nextViewController, sender: nil)
    }
}
