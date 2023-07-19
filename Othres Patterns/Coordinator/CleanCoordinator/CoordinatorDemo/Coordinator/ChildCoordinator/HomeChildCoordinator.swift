//
//  HomeChildCoordinator.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import Foundation
import UIKit

class HomeChildCoordinator: ChildCoordinator {

    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    var message = String()
    
    init(with _navigationController: UINavigationController) {
        self.navigationController = _navigationController
    }
    
    func configureChildViewController() {
        let homeVC = HomeVC.instantiateFromStoryBoard()
        homeVC.msg = message
        self.navigationController.pushViewController(homeVC, animated: true)
    }

    func passParameter(value: Decodable) {
        guard let parameter = value as? HomeChildParameter else { return }
        self.message = parameter.message
    }
}
