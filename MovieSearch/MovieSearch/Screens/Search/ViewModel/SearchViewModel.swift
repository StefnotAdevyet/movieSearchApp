//
//  ViewModel.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

import Foundation

protocol UpdateTable: AnyObject {
    func reloadTable()
    func reloadTable(at: Int)
}

class SearchViewModel: NSObject {
    private var movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = Network()) {
        self.movieService = movieService
    }
    
    func getMovies() {
        movieService.getMovies { success, results, error in
            if success, let movies = results?.results {
                self.fetchData(movies: movies)
            } else {
                print(error!)
            }
        }
    }
    
    var reloadTable: (() -> Void)?
    var movies = Movies()
    var searchCellViewModels = [SearchCellViewModel]() {
        didSet {
            reloadTable?()
        }
    }
    
    func fetchData(movies: Movies) {
        self.movies = movies
        var vms = [SearchCellViewModel]()
        for movie in movies {
            vms.append(configureCell(movie: movie))
        }
        searchCellViewModels = vms
    }
    func configureCell(movie: Movie) -> SearchCellViewModel {
        let title = movie.original_title
        return SearchCellViewModel(name: title)
    }
    func getCellViewModel(at indexPath: IndexPath) -> SearchCellViewModel {
        searchCellViewModels[indexPath.row]
    }
}
