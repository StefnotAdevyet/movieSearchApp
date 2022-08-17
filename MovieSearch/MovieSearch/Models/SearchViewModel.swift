//
//  ViewModel.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

protocol UpdateTable: AnyObject {
    func reloadTable()
    func reloadTable(at: Int)
}

class SearchViewModel {
    private var network: Network? = Network()
    private var feed: DataFeed?
    private var movies: [Movie] {
        feed?.results ?? []
    }
    var numRows: Int {
        feed?.results.count ?? 0
    }
    
    weak var delegate: UpdateTable?
    
    func getTitle(at row: Int) -> String {
        "\(movies[row].original_title)"
    }
    
    func getImg(at row: Int) -> String {
        movies[row].poster_path ?? ""
    }
    
    func fetch(str: String) {
        network?.getMovies(searchTerm: str, completion: { [weak self] result in
            switch result {
            case .success(let feed):
                self?.feed = feed
                self?.delegate?.reloadTable()
            case .failure(let err):
                print(err.rawValue)
            }
        })
    }
}
