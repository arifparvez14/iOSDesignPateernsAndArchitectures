//
//  ViewController.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    var viewModel: HomeViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pickCity(_ sender: Any) {
        viewModel?.didPickCity()
    }
    
    @IBAction func pickRandomCity(_ sender: Any) {
        viewModel?.didPickRandomCity()
    }
}

