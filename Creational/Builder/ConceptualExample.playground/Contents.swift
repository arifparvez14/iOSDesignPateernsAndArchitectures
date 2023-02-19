import Foundation

protocol Builder {
    func producePartA()
    func producePartB()
    func producePartC()
}

class Product1 {
    private var parts = [String]()

    func add(part: String) {
        self.parts.append(part)
    }

    func listParts() -> String {
        return "Product parts: " + parts.joined(separator: ", ") + "\n"
    }
}

class ConcreteBuilder1: Builder{
    private var product = Product1()

    func producePartA() {
        product.add(part: "PartA1")
    }

    func producePartB() {
        product.add(part: "PartB1")
    }

    func producePartC() {
        product.add(part: "PartC1")
    }

    func reset() {
        product = Product1()
    }

    func retrieveProduct() -> Product1 {
        let result = self.product
        reset()
        return result
    }
}

class Director {
    private var builder: Builder?

    func update(builder: Builder) {
        self.builder = builder
    }

    func buildMinimalViableProduct() {
        builder?.producePartA()
    }

    func buildFullFeaturedProduct() {
        builder?.producePartA()
        builder?.producePartB()
        builder?.producePartC()
    }
}

class Client {
    static func someClientCode(director: Director) {
        let builder = ConcreteBuilder1()
        director.update(builder: builder)

        print("Stansard basic product:")
        director.buildMinimalViableProduct()
        print(builder.retrieveProduct().listParts())

        print("Standard full featured product:")
        director.buildFullFeaturedProduct()
        print(builder.retrieveProduct().listParts())

        // Remember, the Builder pattern can be used without a Director class.
        print("Custom product:")
        builder.producePartA()
        builder.producePartC()
        print(builder.retrieveProduct().listParts())
    }
}
