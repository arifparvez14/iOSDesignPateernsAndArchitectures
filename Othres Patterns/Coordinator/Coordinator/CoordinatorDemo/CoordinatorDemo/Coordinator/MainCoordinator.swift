//
//  MainCoordinator.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = [Coordinator]()
    
    init(with _navigationController: UINavigationController) {
        self.navigationController = _navigationController
    }
    
    func configureRootViewController() {
        let loginChildCoordinator = LoginChildCoordinator(with: self.navigationController)
        childCoordinator.append(loginChildCoordinator)
        loginChildCoordinator.mainCoordinator = self
        loginChildCoordinator.configureRootViewController()
    }
    
    func removeFromChildCoordinator(child: Coordinator) {
        for(index, coordintor) in childCoordinator.enumerated() {
            if(coordintor === child) {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
}
