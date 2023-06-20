//
//  Coordinator.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinator: [Coordinator] { get set }
    func configureRootViewController()
}

