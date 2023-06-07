import UIKit

class Tree<T> {
    var value: T
    var left: Tree<T>?
    var right: Tree<T>?

    init(_ value: T) {
        self.value = value
    }

    typealias Block = (T) -> ()

    enum IterationType {
        case inOrder
        case preOrder
        case postOrder
    }

    func iterator(_ type: IterationType) -> AnyIterator<T> {
        var items = [T]()
        switch type {
        case .inOrder:
            inOrder { items.append($0) }
        case .preOrder:
            preOrder { items.append($0) }
        case .postOrder:
            postOrder { items.append($0) }
        }

        return AnyIterator(items.makeIterator())
    }

    private func inOrder(_ body: Block) {
        left?.inOrder(body)
        body(value)
        right?.inOrder(body)
    }

    private func preOrder(_ body: Block) {
        body(value)
        left?.inOrder(body)
        right?.inOrder(body)
    }

    private func postOrder(_ body: Block) {
        left?.inOrder(body)
        right?.inOrder(body)
        body(value)
    }
}

class IteratorRealWorld {
    func test() {
        let tree = Tree(1)
        tree.left = Tree(2)
        tree.right = Tree(3)

        print("Tree traversal: Inorder")
        clientCode(iterator: tree.iterator(.inOrder))

        print("Tree traversal: Preorder")
        clientCode(iterator: tree.iterator(.preOrder))

        print("Tree traversal: Postorder")
        clientCode(iterator: tree.iterator(.postOrder))
    }

    func clientCode<T>(iterator: AnyIterator<T>) {
        while case let item? = iterator.next() {
            print(item)
        }
    }
}
