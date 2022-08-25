//
//  DetailViewModel.swift
//  MovieSearch
//
//  Created by developer on 8/16/22.
//

import Foundation


class DetailViewModel {
    private var movie: Movie!
    
    
    func getTitle() -> String {
        movie.original_title
    }
    
    func getDescription() -> String {
        movie.overview
    }

    
//    network.getImage(imgSrc: imgSrc) { result in
//        switch result {
//        case .success(let imageData):
//            DispatchQueue.main.async {
//                self.posterView.image = UIImage(data: imageData)
//            }
//        case .failure(let error):
//            print("Error fetching image", error.rawValue)
//        }
//    }
}
