import UIKit

protocol DomainModel {
    
    var id: Int { get }
}

struct User: DomainModel {
    
    var id: Int
    var username: String
}

//MARK: - DataSource
protocol DataSource {
    
    func loadModels<T: DomainModel>() -> [T]
}

class MemoryStorage<Model>: DataSource {
    
    private lazy var items = [Model]()
    
    func add(_ items: [Model]) {
        self.items.append(contentsOf: items)
    }
    
    func loadModels<T>() -> [T] where T : DomainModel {
        guard T.self == User.self else { return [] }
        return items as! [T]
    }
}

class CoreDataStorage: DataSource {
    
    func loadModels<T>() -> [T] where T : DomainModel {
        guard T.self == User.self else { return [] }
        
        let firstUser = User(id: 3, username: "username3")
        let secondtUser = User(id: 4, username: "username4")
        
        return [firstUser, secondtUser] as! [T]
    }
}

class RealmStorage: DataSource {
    
    func loadModels<T>() -> [T] where T : DomainModel {
        guard T.self == User.self else { return [] }
        
        let firstUser = User(id: 3, username: "username3")
        let secondtUser = User(id: 4, username: "username4")
        
        return [firstUser, secondtUser] as! [T]
    }
}

//MARK: - ListController
class ListController {
    
    private var dataSource: DataSource?
    
    func update(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func displayModels() {
        
        guard let dataSource = dataSource else { return }
        let models = dataSource.loadModels() as [User]
        
        print("\nListController: Display models...")
        models.forEach { print($0) }
    }
}

//MARK: - StrategyRealWorld
class StrategyRealWorld {
    func test() {
        
        let controller = ListController()
        
        let memoryStorage = MemoryStorage<User>()
        memoryStorage.add(usersFromNetwork())
        
        clientCode(user: controller, with: memoryStorage)
        
        clientCode(user: controller, with: CoreDataStorage())
        
        clientCode(user: controller, with: RealmStorage())
    }
    
    func clientCode(user controller: ListController, with dataSource: DataSource) {
        
        controller.update(dataSource: dataSource)
        controller.displayModels()
    }
    
    private func usersFromNetwork() -> [User] {
        let firstUser = User(id: 1, username: "username1")
        let secondUser = User(id: 2, username: "username2")
        return [firstUser, secondUser]
    }
}

var strategyRealWorld = StrategyRealWorld()
strategyRealWorld.test()






