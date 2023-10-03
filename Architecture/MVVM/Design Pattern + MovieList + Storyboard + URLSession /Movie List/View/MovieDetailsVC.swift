//
//  MovieDetailsVC.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 3/8/23.
//

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var ticketPriceLabel: UILabel!

    let ticketPriceRange: (Int, Int) = (0, 10)
    var ticketPriceCount: Int = 0
    var movie: MovieResult!

    override func viewDidLoad() {
        super.viewDidLoad()

        detailLabel.text = movie.title
        detailTextView.text = movie.overview
        imageView.image = UIImage(named: defaultThumbnailImageName)
        if let url = movie.posterUrl {
            imageView.loadImage(fromUrl: url)
        }
    }

    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        CartManager.sharedInstance.add(movieResult: self.movie)
    }

    @IBAction func plusButtonTap(_ sender: UIButton) {
        if ticketPriceCount < ticketPriceRange.1 {
            ticketPriceCount = ticketPriceCount + 1
            ticketPriceLabel.text = "\(ticketPriceCount)"
        }
    }


    @IBAction func minusButtonTap(_ sender: UIButton) {
        if ticketPriceCount > ticketPriceRange.0 {
            ticketPriceCount = ticketPriceCount - 1
            ticketPriceLabel.text = "\(ticketPriceCount)"
        }
    }
}

extension MovieDetailsVC: StoryboardBased {
    static var storyboardName: String {
        return "Main"
    }
}
