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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
