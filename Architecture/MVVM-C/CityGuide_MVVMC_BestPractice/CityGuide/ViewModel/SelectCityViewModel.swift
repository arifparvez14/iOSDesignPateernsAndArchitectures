//
//  SelectCityViewModel.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import Foundation

class SelectCityViewModel: SelectCityViewModeling {
    
    weak var coordination: SelectCityModelCoordinationDelegate?
    weak var dataDelegate: SelectCityModelDataDelegate?
    
    var source = [String]()
    
    func loadCityListData() {
        for city in self.cities {
            self.source.append(city.name)
        }
        self.dataDelegate?.itemDidChange()
    }
    
    var numOfItems: Int {
        source.count
    }
    
    func isMovingToRoot() {
        coordination?.dismissList()
    }
    
    fileprivate var cities: [City] {
        get {
            return Cities().cities()
        }
    }
}
