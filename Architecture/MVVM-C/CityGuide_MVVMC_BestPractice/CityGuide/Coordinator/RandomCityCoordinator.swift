//
//  SelectRandomCityCoordinator.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class RandomCityCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RandomCityViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
}
