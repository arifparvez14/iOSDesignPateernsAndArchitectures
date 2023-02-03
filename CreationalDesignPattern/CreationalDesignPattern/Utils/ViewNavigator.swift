//
//  ViewNavigator.swift
//  CreationalDesignPattern
//
//  Created by Muhammad Ariful Islam on 3/2/23.
//

import UIKit

class ViewNavigator {
    static func navigateToView(using viewController: UIViewController, and index: Int) {
        let mainSB = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        
        if index == 0 {
            let factoryVC = FactoryViewController()
            factoryVC.viewTitle = Helper.getTopicName(index)
            viewController.navigationController?.pushViewController(factoryVC, animated: true)
        }
    }
}
