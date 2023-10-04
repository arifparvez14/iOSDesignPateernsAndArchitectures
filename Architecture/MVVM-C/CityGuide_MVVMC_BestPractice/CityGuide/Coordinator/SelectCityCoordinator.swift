//
//  SelectCityCoordinator.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

protocol SelectCityCoordinatorDelegate: AnyObject {
    func listCoordinatorDidFinish()
}

class SelectCityCoordinator: NSObject, Coordinator, UINavigationControllerDelegate{
    
    var navigationController: UINavigationController
    weak var delegate: SelectCityCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = SelectCityViewController.instantiate()
        
        let viewModel = SelectCityViewModel()
        vc.viewModel = viewModel
        viewModel.coordination = self
        
        navigationController.pushViewController(vc, animated: true)
    }
}

extension SelectCityCoordinator: SelectCityModelCoordinationDelegate {
    func dismissList() {
        delegate?.listCoordinatorDidFinish()
    }
}

