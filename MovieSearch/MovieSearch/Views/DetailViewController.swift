//
//  DetailViewController.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

import UIKit

class DetailViewController: UIViewController {
    static let id = String(describing: DetailViewController.self)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var synopsisView: UITextView!
    private var network: Network = Network()
    
    var imgSrc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        network.getImage(imgSrc: imgSrc) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.posterView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print("Error fetching image", error.rawValue)
            }
        }
    }
}
