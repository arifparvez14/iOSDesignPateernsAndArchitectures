//
//  LoginChildCoordinator.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

class LoginChildCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = [Coordinator]()
    weak var mainCoordinator: MainCoordinator?
    
    init(with _navigationController: UINavigationController) {
        self.navigationController = _navigationController
    }
    
    func configureRootViewController() {
        let vc = LoginVC.instantiateFromStoryBoard()
        vc.loginChildCoordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToHomeVC(with message: String) {
        let homeChildCoordinator = HomeChildCoordinator(with: self.navigationController, message: message)
        mainCoordinator?.childCoordinator.append(homeChildCoordinator)
        mainCoordinator?.removeFromChildCoordinator(child: self)
        homeChildCoordinator.configureRootViewController()
    }
    
    func navigateToSignupVC() {
        let vc = SignupVC.instantiateFromStoryBoard()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToResetPasswardVC() {
        let vc = ResetPasswardVC.instantiateFromStoryBoard()
        self.navigationController.pushViewController(vc, animated: true)
    }
}
