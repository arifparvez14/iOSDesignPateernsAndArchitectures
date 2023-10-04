//
//  HomeViewModelProtocol.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 4/10/23.
//

import Foundation

protocol HomeViewModelCoordinationDelegate: AnyObject {
    func pickCity()
    func PickRandomCity()
}

protocol HomeViewModeling {
    var coordinationdelegate: HomeViewModelCoordinationDelegate? {get set}
    func didPickCity()
    func didPickRandomCity()
}
