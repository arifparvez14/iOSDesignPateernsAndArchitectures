import Foundation

//MARK: - Creator
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

//MARK: - Product
protocol Product {
    func operation() -> String
}

class ConcreteProduct1: Product {
    func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}

//MARK: - Client
class Client {
    static func someClientCode(creator: Creator) {
        print("Client: I'm not aware of the creator's class, but it still works.\n"
              + creator.someOperation())
    }
}

//MARK: - FactoryMethodConceptual
class FactoryMethodConceptual {
    func testFactoryMethodConceptual() {
        print("App: Launched with the ConcreteCreator1.")
        Client.someClientCode(creator: ConcreteCreator1())
    }
}

let fm = FactoryMethodConceptual()
fm.testFactoryMethodConceptual()
