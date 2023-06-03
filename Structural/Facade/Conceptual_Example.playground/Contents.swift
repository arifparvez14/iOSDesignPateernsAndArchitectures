import UIKit

class Flyweight {
    private let sharedState: [String]
    
    init(sharedState: [String]) {
        self.sharedState = sharedState
    }
    
    func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState) state.\n")
    }
}

class FlyweightFactory {
    private var flyweights: [String: Flyweight]
    
    init(states: [[String]]) {
        
        var flyweights = [String: Flyweight]()
        
        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }
        
        self.flyweights = flyweights
    }
    
    func flyweight(for state: [String]) -> Flyweight {
        
        let key = state.key
        
        guard let foundFlyweight = flyweights[key] else {
            
            print("FlyweightFactory: Can't find a flyweight, creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        print("FlyweightFactory: Reusing existing flyweight.\n")
        return foundFlyweight
    }
    
    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        for item in flyweights {
            print(item.key)
        }
    }
}

extension Array where Element == String {
    
    /// Returns a Flyweight's string hash for a given state.
    var key: String {
        return self.joined()
    }
}

let factory = FlyweightFactory(states:
        [
            ["Chevrolet", "Camaro2018", "pink"],
            ["Mercedes Benz", "C300", "black"],
            ["Mercedes Benz", "C500", "red"],
            ["BMW", "M5", "red"],
            ["BMW", "X6", "white"]
        ])

factory.printFlyweights()
