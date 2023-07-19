//
//  ChildCoordinatorFactory.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 21/6/23.
//

import UIKit

enum childCoordinatorType {
    case login
    case home
}

class ChildCoordinatorFactory {
    static func create(with _navigationController: UINavigationController, type: childCoordinatorType) -> ChildCoordinator {

        switch type {
        case .login:
            return LoginChildCoordinator(with: _navigationController)
        case .home:
            return HomeChildCoordinator(with: _navigationController)
        }
    }
}
