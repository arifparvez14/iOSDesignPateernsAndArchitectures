//
//  CitySource.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import Foundation

struct City {
    let name: String
    let data: String
}

struct Cities {
    func cities() -> Array<City> {
        var array = [City]()
        for dict in source() {
            let city = City(name: dict["city"]!, data: dict["data"]!)
            array.append(city)
        }
        return array
    }
    
    func source() -> Array<Dictionary<String, String>> {
        return [["city":"Taipei","data":"Taiwan"],
                ["city":"Tokyo","data":"Japan"],
                ["city":"Singapore","data":"Singapore"],
                ["city":"New York","data":"United State"],
                ["city":"London","data":"England"],
                ["city":"Shanghai","data":"China"],
                ["city":"Moscow","data":"Russia"],
                ["city":"Istanbul","data":"Turkey"]]
    }
    
    func randomCity() -> City {
        let dict = source()[Int(arc4random()) % source().count]
        return City(name: dict["city"]!, data: dict["data"]!)
    }
}
