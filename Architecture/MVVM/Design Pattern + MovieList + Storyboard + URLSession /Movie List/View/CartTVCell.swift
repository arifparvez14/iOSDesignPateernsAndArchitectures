//
//  CartTVCell.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 5/8/23.
//

import UIKit

class CartTVCell: UITableViewCell {

    @IBOutlet weak var cartItemIV: UIImageView!
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var itemTotalLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
