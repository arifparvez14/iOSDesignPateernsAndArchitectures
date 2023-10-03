//
//  MovieThumbnailCV.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 3/8/23.
//

import UIKit

class MovieThumbnailCV: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell( posterUrl: URL?) {
        thumbnailImageView.image = UIImage(named: defaultThumbnailImageName)

        if let imageUrl = posterUrl {
            thumbnailImageView.loadImage(fromUrl: imageUrl)
        }
    }

}
