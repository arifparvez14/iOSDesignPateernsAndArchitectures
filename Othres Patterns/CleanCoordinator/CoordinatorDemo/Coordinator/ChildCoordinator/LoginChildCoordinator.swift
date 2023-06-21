//
//  LoginChildCoordinator.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

class LoginChildCoordinator: ChildCoordinator {

    var navigationController: UINavigationController
    weak var parentCoordinator: ParentCoordinator?
    
    init(with _navigationController: UINavigationController) {
        self.navigationController = _navigationController
    }
    
    func configureChildViewController() {
        let vc = LoginVC.instantiateFromStoryBoard()
        vc.loginChildCoordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToHomeVC(with message: String) {
        let homeChildCoordinator = ChildCoordinatorFactory.create(with: parentCoordinator!.navigationController, type: .home)
        homeChildCoordinator.passParameter(value: HomeChildParameter(message: message))

        parentCoordinator?.childCoordinator.append(homeChildCoordinator)
        parentCoordinator?.removeChildCoordinator(child: self)
        homeChildCoordinator.configureChildViewController()
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
