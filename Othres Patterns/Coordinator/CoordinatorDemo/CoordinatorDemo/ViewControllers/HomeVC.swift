//
//  HomeVC.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

class HomeVC: UIViewController, CoordinatorBoard {
    
    @IBOutlet weak var msgLabel: UILabel!
    
    weak var homeChildCoordinator: HomeChildCoordinator?
    
    var msg: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        msgLabel.text = msg
    }
}
