import Foundation

// Functions that use pointers of references to base classes must be able to use objects of derived classes without knowing it.

// ** Preconditions Changes **

/*
 - We have a class Handler, it has the responsibility to save a string in a cloud service. Then, the business logic changes, and, sometimes, you must save the string just if its length is greater than five. Therefore, we decide to create a subclass FilteredHandler.
 */


class Handler {

    func save(string: String) {
        // Save string in the Cloud
    }
}

class FilteredHandler: Handler {

    override func save(string: String) {
        guard string.utf8CString.count > 5 else { return }

        super.save(string: string)
    }
}

/*
 - This example breaks LSP because, in the subclass, we add the precondition that string must have a length greater than 5.
 - A client of Handler doesn’t expect that FilteredHandler has a different precondition, since it should be the same for Handler and all its subclasses.
 - We can solve this problem getting rid of FilteredHandler and adding a new parameter to inject the minimum length of characters to filter:
 */

class Handlerr {

    func save(string: String, minChars: Int = 0) {
        guard string.utf8CString.count >= minChars else { return }

        // Save string in the Cloud
    }
}

// ** Postconditions Changes **

/*
 - We have a project where we must compute the area of some rectangle objects—so we create the class Rectangle.
 - After a couple of months, we need to compute also the area of square objects—so we decide to create a subclass Square.
 - Since in a square we need just a side to compute the area—and we don’t want to override the computation of area—we decide to assign the same value of width to length:
 */

class Rectangle {

    var width: Float = 0
    var length: Float = 0

    var area: Float {
        return width * length
    }
}

class Square: Rectangle {

    override var width: Float {
        didSet {
            length = width
        }
    }
}

// With this approach, we break LSP because if the client has the current method. The result should always be the same in the both calls.

func printArea(of rectangle: Rectangle) {
    rectangle.length = 5
    rectangle.width = 2
    print(rectangle.area)
}

let rectangle = Rectangle()
printArea(of: rectangle) // 10

let square = Square()
printArea(of: square) // 4

// We can solve it using a protocol with a method area, implemented by Rectangle and Square in different ways.

protocol Polygon {
    var area: Float { get }
}

class LSRectangle: Polygon {

    private let width: Float
    private let length: Float

    init(width: Float, length: Float) {
        self.width = width
        self.length = length
    }

    var area: Float {
        return width * length
    }
}

class LSSquare: Polygon {

    private let side: Float

    init(side: Float) {
        self.side = side
    }

    var area: Float {
        return pow(side, 2)
    }
}

func printArea(of polygon: Polygon) {
    printArea(of: polygon)
}

let rect = LSRectangle(width: 2, length: 5)
printArea(of: rectangle) // 10

let squares = LSSquare(side: 2)
printArea(of: square) // 4

