//
//  MainCoordinator.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate{
    
    var childCoordinator: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ViewController.instantiate()
        
        let viewModel =  HomeViewModel()
        vc.viewModel = viewModel
        viewModel.delegate = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func selectCity() {
        let child = SelectCityCoordinator(navigationController: self.navigationController)
        child.parentCoordinator = self
        
        childCoordinator.append(child)
        child.start()
    }
    
    func randomCity() {
        let child = RandomCityCoordinator(navigationController: self.navigationController)
        child.parentCoordinator = self
        
        childCoordinator.append(child)
        child.start()
    }
    
}

extension MainCoordinator: HomeViewModelCoordinationDelegate {
    func pickCity() {
        selectCity()
    }

    func PickRandomCity() {
        randomCity()
    }
}
