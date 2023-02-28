import Foundation

// cannot inherit from a string
class CodeBuilder: CustomStringConvertible {
    private var buffer: String = ""
    var description: String {
        return buffer
    }

    init(){}
    init(_ buffer: String) {
        self.buffer = buffer
    }

    func clear() {
        buffer = ""
    }

    // interface replicating the original fluent interface
    func append(_ s: String) -> CodeBuilder {
        buffer.append(s)
        return self
    }

    // add your own customizations
    func addLine(_ s: String) -> CodeBuilder {
        buffer.append("\(s)\n")
        return self
    }

    // replicate string's operator
    static func += (cb: inout CodeBuilder, s: String) {
        cb.buffer.append(s)
    }
}

var cb = CodeBuilder()
cb.addLine("Class Foo").addLine("{")

cb += " testing\n"

cb.addLine("}")
print(cb)

