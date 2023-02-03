//
//  Helper.swift
//  CreationalDesignPattern
//
//  Created by Muhammad Ariful Islam on 3/2/23.
//

import Foundation

class Helper {
    private static var topicsData = [String]()
    
    static func prepareData() {
        topicsData.append("Factory")
    }
    
    static func getTopicsCount() -> Int {
        return self.topicsData.count
    }
    
    static func getTopicName(_ index: Int) -> String {
        return self.topicsData[index]
    }
}

enum StoryboardName: String {
    case main = "Main"
}

enum ViewControllerName: String {
    case factory = "FactoryViewController"
}

enum TableViewCellIdentifier: String {
    case itemTableViewCellID = "ItemTVCell"
}

