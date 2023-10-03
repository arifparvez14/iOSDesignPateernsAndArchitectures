//
//  CategoryCollectionViewCell.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 2/8/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10.0
    }

    func configCell(categoryName: String) {
        self.categoryName.text = categoryName
    }
}
