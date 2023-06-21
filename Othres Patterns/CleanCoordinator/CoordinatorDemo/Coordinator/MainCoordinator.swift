//
//  MainCoordinator.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

class MainCoordinator: ParentCoordinator {

    var navigationController: UINavigationController
    var childCoordinator: [ChildCoordinator] = [ChildCoordinator]()
    
    init(with _navigationController: UINavigationController) {
        self.navigationController = _navigationController
    }
    
    func configureRootViewController() {
        let loginChildCoordinator = ChildCoordinatorFactory.create(with: self.navigationController, type: .login)
        childCoordinator.append(loginChildCoordinator)

        loginChildCoordinator.parentCoordinator = self
        loginChildCoordinator.configureChildViewController()
    }
    
    func removeChildCoordinator(child: ChildCoordinator) {
        for(index, coordintor) in childCoordinator.enumerated() {
            if(coordintor === child) {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
}
