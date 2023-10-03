//
//  MainTabBarVCViewController.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 4/8/23.
//

import UIKit

class MainTabBarVCViewController: UITabBarController, StoryboardBased {

    @IBOutlet weak var tabbar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabbar.layer.backgroundColor = UIColor.lightGray.cgColor
    }

    static var storyboardName: String {
        return "Main"
    }
}


