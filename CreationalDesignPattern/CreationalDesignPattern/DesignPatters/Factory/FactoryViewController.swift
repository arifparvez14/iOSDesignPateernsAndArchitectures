//
//  FactoryViewController.swift
//  CreationalDesignPattern
//
//  Created by Muhammad Ariful Islam on 3/2/23.
//

import UIKit

class FactoryViewController: UIViewController {
    var viewTitle: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let fm = FactoryMethodConceptual()
        fm.testFactoryMethodConceptual()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = viewTitle
    }
}

protocol Product {
    func operation() -> String
}

protocol Creator {
    func factoryMethod() -> Product
    func someOperation() -> String
}

extension Creator {
    func someOperation() -> String {
        let product = factoryMethod()
        return "Creator: The same creator's code has just worked with " + product.operation()
    }
}

class ConcreteCreator1: Creator {
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteProduct1: Product {
    func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}

class Client {
    static func someClientCode(creator: Creator) {
        print("Client: I'm not aware of the creator's class, but it still works.\n"
              + creator.someOperation())
    }
}

class FactoryMethodConceptual {
    func testFactoryMethodConceptual() {
        print("App: Launched with the ConcreteCreator1.")
        Client.someClientCode(creator: ConcreteCreator1())
    }
}

