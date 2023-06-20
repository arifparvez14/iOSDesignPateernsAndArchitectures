//
//  HomeChildCoordinator.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import Foundation
import UIKit

class HomeChildCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = [Coordinator]()
    private var homeMessage: String
    
    init(with _navigationController: UINavigationController, message: String) {
        self.navigationController = _navigationController
        self.homeMessage = message
    }
    
    func configureRootViewController() {
        let homeVC = HomeVC.instantiateFromStoryBoard()
        homeVC.msg = homeMessage
        self.navigationController.pushViewController(homeVC, animated: true)
    }
}
