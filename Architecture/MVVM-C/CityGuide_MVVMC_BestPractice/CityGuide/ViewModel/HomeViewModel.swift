//
//  HomeViewModel.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import Foundation

class HomeViewModel: HomeViewModeling {
    
    weak var coordinationdelegate: HomeViewModelCoordinationDelegate?
    
    func didPickCity() {
        coordinationdelegate?.pickCity()
    }
    
    func didPickRandomCity() {
        coordinationdelegate?.PickRandomCity()
    }
}
