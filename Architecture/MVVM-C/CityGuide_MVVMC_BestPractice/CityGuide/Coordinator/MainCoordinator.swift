//
//  MainCoordinator.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate{
    
    fileprivate let Home_KEY: String  = "Home"
    fileprivate let CITY_LIST_KEY: String  = "CityList"
    fileprivate let RANDOM_CITY_LIST_KEY: String  = "RandomCityList"
    
    var coordinators = [String:Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        coordinators[Home_KEY] = self
        
        let vc = ViewController.instantiate()
        let viewModel =  HomeViewModel()
        vc.viewModel = viewModel
        viewModel.coordinationdelegate = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func selectCity() {
        let child = SelectCityCoordinator(navigationController: self.navigationController)
        coordinators[CITY_LIST_KEY] = child
        
        child.delegate = self
        child.start()
    }
    
    func randomCity() {
        let child = RandomCityCoordinator(navigationController: self.navigationController)
        coordinators[RANDOM_CITY_LIST_KEY] = child
        
        
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

extension MainCoordinator: SelectCityCoordinatorDelegate {
    func listCoordinatorDidFinish() {
        coordinators[CITY_LIST_KEY] = nil
    }
}
