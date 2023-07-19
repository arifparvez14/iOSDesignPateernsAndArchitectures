//
//  CoordinatorBoard.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

protocol CoordinatorBoard: UIViewController {
    
    static func instantiateFromStoryBoard() -> Self
}

extension CoordinatorBoard {
    static func instantiateFromStoryBoard() -> Self {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let id = String(describing: self)
        return storyBoard.instantiateViewController(withIdentifier: id) as! Self
    }
}
