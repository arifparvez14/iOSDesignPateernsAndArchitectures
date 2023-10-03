//
//  BuyCoordinator.swift
//  CoordinatorTest
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class BuyCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    var selectedProduct = 0
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    /*
    func didFinishBuying() {
        parentCoordinator?.childDidFinish(self)
    }
    */
}
