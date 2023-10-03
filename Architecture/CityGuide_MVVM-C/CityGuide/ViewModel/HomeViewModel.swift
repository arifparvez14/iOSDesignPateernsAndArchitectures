//
//  HomeViewModel.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func pickCity()
    func PickRandomCity()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelProtocol?
    
    func didPickCity() {
        delegate?.pickCity()
    }
    
    func didPickRandomCity() {
        delegate?.PickRandomCity()
    }
}
