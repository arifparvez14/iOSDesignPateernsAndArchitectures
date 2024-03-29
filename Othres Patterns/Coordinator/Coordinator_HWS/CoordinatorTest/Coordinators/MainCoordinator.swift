//
//  MainCoordinator.swift
//  CoordinatorTest
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinator: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func buySubscription(to productType: Int) {
        let child = BuyCoordinator(navigationController: self.navigationController)
        
        //This is keep track from which parent child is created.
        child.parentCoordinator = self
        child.selectedProduct = productType
        
        childCoordinator.append(child)
        child.start()
    }
    
    func createAccount() {
        let vc = AccountViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinator.enumerated() {
            if coordinator === child {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let buyViewController = fromViewController as? BuyViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(buyViewController.coordinator)
        }
    }
}
