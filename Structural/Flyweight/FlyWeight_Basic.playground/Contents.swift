import Foundation

//MARK: - Check total char without optimization
class User {
    var fullName: String

    init(_ fullName: String) {
        self.fullName = fullName
    }

    var charCount: Int {
        return fullName.utf8.count
    }
}

let user1 = User("John Smith")
let user2 = User("Jane Smith")
let user3 = User("Jane Doe")

let totalChars = user1.charCount + user2.charCount + user3.charCount
print("Total number of chars used: \(totalChars)")

//MARK: - Save memory using Flyweight
class Users {
    static var strings = [String]()
    private var names = [Int]()

    init(_ fullName: String) {
        names = fullName.components(separatedBy: " ").map { getOrAdd($0) }
    }

    private func getOrAdd(_ s: String) -> Int {
        if let idx = type(of: self).strings.index(of: s) {
            return idx
        } else {
            type(of: self).strings.append(s)
            return type(of: self).strings.count + 1
        }
    }

    static var charCount: Int {
        return strings.map{ $0.utf8.count }.reduce(0, +)
    }
}

let user4 = Users("John Smith")
let user5 = Users("Jane Smith")
let user6 = Users("Jane Doe")

print("Total number of users chars used: \(Users.charCount)")
