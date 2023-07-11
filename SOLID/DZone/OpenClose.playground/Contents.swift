import Foundation

/*
 - Open for extension: You should be able to extend or change the behaviors of a class without efforts.
 
 - Closed for modification: You must extend a class without changing the implementation.
 */

class Car {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func printDetails() -> String {
        return "I'm \(name) and my color is \(color)"
    }
}

class Logger {
    func printData() {
        let cars = [
            Car(name: "Batmobile", color: "Black"),
            Car(name: "SuperCar", color: "Gold"),
            Car(name: "FamilyCar", color: "Grey")
        ]
        
        cars.forEach { car in
            print(car.printDetails())
        }
    }
}

//Logger().printData()

//If we want to add the possibility to print also the details of a new class, we should change the implementation of printData every time we want to log a new class—breaking OCP:

class UpdatedCar {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func printDetails() -> String {
        return "I'm \(name) and my color is \(color)"
    }
}

class UpdatedBicycle {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    func printDetails() -> String {
        return "I'm a \(type)"
    }
}

class UpdatedLogger {
    
    func printData() {
        let cars = [
            UpdatedCar(name: "Batmobile", color: "Black"),
            UpdatedCar(name: "SuperCar", color: "Gold"),
            UpdatedCar(name: "FamilyCar", color: "Grey")
        ]
        
        cars.forEach { car in
            print(car.printDetails())
        }
        
        let bicycles = [
            UpdatedBicycle(type: "BMX"),
            UpdatedBicycle(type: "Tandem")
        ]
        
        bicycles.forEach { bicycles in
            print(bicycles.printDetails())
        }
    }
}

//UpdatedLogger().printData()

/*
- We can solve this problem creating a new protocol Printable, which will be implemented by the classes to log. Finally, printData will print an array of Printable.

- In this way, we create a new abstract layer between printData and the class to log, allowing the print of other classes like Bicycle and without changing the printData implementation.
 */

protocol Printable {
    func printDetails() -> String
}

class OCCar: Printable {
    let name: String
    let color: String

    init(name: String, color: String) {
        self.name = name
        self.color = color
    }

    func printDetails() -> String {
        return "I'm \(name) and my color is \(color)"
    }
}

class OCBicycle: Printable {
    let type: String

    init(type: String) {
        self.type = type
    }

    func printDetails() -> String {
        return "I'm a \(type)"
    }
}

class OCLogger {

    func printData() {
        let cars: [Printable] = [
            OCCar(name: "Batmobile", color: "Black"),
            OCCar(name: "SuperCar", color: "Gold"),
            OCCar(name: "FamilyCar", color: "Grey"),
            OCBicycle(type: "BMX"),
            OCBicycle(type: "Tandem")
        ]

        cars.forEach { car in
            print(car.printDetails())
        }
    }
}

OCLogger().printData()

