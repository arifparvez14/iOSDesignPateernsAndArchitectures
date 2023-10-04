//
//  SelectCityModelProtocol.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 4/10/23.
//

import Foundation

protocol SelectCityModelDataDelegate: AnyObject {
    func itemDidChange()
}

protocol SelectCityModelCoordinationDelegate: AnyObject {
    func dismissList()
}

protocol SelectCityViewModeling {
    var coordination: SelectCityModelCoordinationDelegate? { get set }
    var dataDelegate: SelectCityModelDataDelegate? { get set }
    var source:[String] { get }
    var numOfItems: Int { get }
    func isMovingToRoot()
    func loadCityListData()
}
