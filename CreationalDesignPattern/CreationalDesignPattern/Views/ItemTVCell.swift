//
//  ItemTVCell.swift
//  iOSTutorial
//

import UIKit

class ItemTVCell: UITableViewCell {

    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContainerView.layer.cornerRadius = 8.0
    }
}
