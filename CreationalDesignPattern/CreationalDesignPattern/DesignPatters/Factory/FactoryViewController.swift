//
//  FactoryViewController.swift
//  CreationalDesignPattern
//
//  Created by Muhammad Ariful Islam on 3/2/23.
//

import UIKit

class FactoryViewController: UIViewController {
    var viewTitle: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = viewTitle
    }
}
