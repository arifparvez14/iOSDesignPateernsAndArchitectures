import Foundation

//MARK: - Person
class Person: CustomStringConvertible {
    //address
    var streetAddress = "", postcode = "", city = ""
    
    //employment
    var companyName = "", position = "", annualIncome = ""
    
    var description: String {
        return "I live at \(streetAddress), \(postcode), \(city). " +
        "I work at \(companyName) as a \(position), earning \(annualIncome)"
    }
}

//MARK: - PersonBuilder
class PersonBuilder {
    var person = Person()
    var lives: PersonAddressBuilder {
        return PersonAddressBuilder(person)
    }
    var works: PersonJobBuilder {
        return PersonJobBuilder(person)
    }
    
    func build() -> Person {
        return person
    }
    
}

//MARK: - PersonAddressBuilder
class PersonAddressBuilder: PersonBuilder {
    internal init(_ person: Person) {
        super.init()
        self.person = person
    }
    
    func at(_ streetAddress: String) -> PersonAddressBuilder {
        person.streetAddress = streetAddress
        return self
    }
    
    func withPostCode(_ postcode: String) -> PersonAddressBuilder {
        person.postcode = postcode
        return self
    }
    
    func inCity(_ city: String) -> PersonAddressBuilder {
        person.city = city
        return self
    }
}

//MARK: - PersonJobBuilder
class PersonJobBuilder: PersonBuilder {
    internal init(_ person: Person) {
        super.init()
        self.person = person
    }
    
    func at(_ companyName: String) -> PersonJobBuilder {
        person.companyName = companyName
        return self
    }
    
    func asA(_ position: String) -> PersonJobBuilder {
        person.position = position
        return self
    }
    
    func earning(_ annualIncome: String) -> PersonJobBuilder {
        person.annualIncome = annualIncome
        return self
    }
}

let personBuilder = PersonBuilder()
let pb = personBuilder
    .lives.at("Jatrabari").inCity("Dhaka").withPostCode("1362")
    .works.at("BJIT").asA("Senior Software Engineer").earning("$$$")
    .build()

print(pb)
