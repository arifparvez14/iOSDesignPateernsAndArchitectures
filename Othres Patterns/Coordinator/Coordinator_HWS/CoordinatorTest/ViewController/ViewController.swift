//
//  ViewController.swift
//  CoordinatorTest
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var selectedIndex: Int = 0
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buyTapped(_ sender: Any) {
        coordinator?.buySubscription(to: segmentedController.selectedSegmentIndex)
    }
    
    @IBAction func accountTapped(_ sender: Any) {
        coordinator?.createAccount()
    }
}

