//
//  HomeViewModel.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import Foundation

class HomeViewModel: HomeViewModeling {
    
    weak var delegate: HomeViewModelCoordinationDelegate?
    
    func didPickCity() {
        delegate?.pickCity()
    }
    
    func didPickRandomCity() {
        delegate?.PickRandomCity()
    }
}
