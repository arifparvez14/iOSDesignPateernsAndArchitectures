//
//  SelectCityCoordinator.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class SelectCityCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SelectCityViewController.instantiate()
        vc.coordinator = self
        
        let viewModel = SelectCityViewModel()
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
}
