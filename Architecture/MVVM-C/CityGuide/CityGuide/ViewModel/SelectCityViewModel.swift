//
//  SelectCityViewModel.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import Foundation

struct SelectCityViewModel {
    var source = [String]()
    
    init() {
        for city in cities {
            source.append(city.name)
        }
    }
    
    fileprivate var cities: [City] {
        get {
            return Cities().cities()
        }
    }
}
