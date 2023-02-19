import Foundation

protocol Copying {
  // the 'required' keyword is only used in classes
  init(copyFrom other: Self)
}

class Address: CustomStringConvertible, Copying {
    var streetAdress: String
    var city: String
    
    var description: String {
        return "\(streetAdress), \(city)"
    }
    
    init(_ streetAdress: String, _ city: String) {
        self.streetAdress = streetAdress
        self.city = city
    }
    
    required init(copyFrom other: Address) {
        streetAdress = other.streetAdress
        city = other.city
    }
}

struct Employee: CustomStringConvertible, Copying {
    var name: String
    var address: Address
    
    var description: String {
        return "My name is \(name) and I live at \(address)"
    }
    
    init(_ name: String, _ address: Address){
        self.name = name
        self.address = address
    }
    
    /*required*/ init(copyFrom other: Employee) {
        name = other.name
        
        //one option is to do this
        //address = Address(other.address.streetAdress, other.address.city)
        
        //other option is to do this
        address = Address(copyFrom: other.address)
        
    }
}

var john = Employee("John", Address("123 London Road", "London"))
// if employee is a class, these refer to the same obj
// if employee is a struct, a copy is made
// var chris = john


var chris = Employee(copyFrom: john)
chris.name = "Chris"
chris.address.city = "Manchester"

// if address is a class, they both end up in Manchester
// if address is a struct, a copy is made

print(john.description)
print(chris.description)


