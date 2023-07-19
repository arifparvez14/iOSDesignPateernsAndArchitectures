import Foundation

/*
 - An object receives other objects that it depends on. These other objects are called dependencies.
 - Receiving object is called a client and the passed (injected) object is called a service.
 - The code that passes the service to the client can be many kinds of things and is called the injector.
 - Instead of the client specifying which service it will use, the injector tells the client what service to use.
 */

/*
 We can implement the Dependency Injection in several ways.
 These ways are
 - Initializer Injection,
 - Setter Injection(a.k.a Property Injection), and
 - Interface Injection.
 */

// Initializer Injection
// Pass all the dependencies as initializer parameters.

protocol UserServiceProtocol {
    func fetchUsers()
}

protocol RewardServiceProtocol {
    func fetchRewards()
}

final class ViewModel {

    private let userService: UserServiceProtocol
    private let rewardService: RewardServiceProtocol

    init(userService: UserServiceProtocol, rewardService: RewardServiceProtocol) {
        self.userService = userService
        self.rewardService = rewardService
    }

}

// Setter Injection
// The Setter Injection technique needs a setter method to inject dependencies.

protocol UserServiceProtocol {
    func fetchUsers()
}

protocol RewardServiceProtocol {
    func fetchRewards()
}

final class ViewModel {

    private var userService: UserServiceProtocol?
    private var rewardService: RewardServiceProtocol?

    func setUserService(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func setRewardService(rewardService: RewardServiceProtocol) {
        self.rewardService = rewardService
    }
}

// Interface Injection
// Client conforms to protocols used to inject dependencies

protocol UserServiceProtocol {
    func fetchUsers()
}

protocol RewardServiceProtocol {
    func fetchRewards()
}

protocol ServiceProtocol {
    func users(service: UserServiceProtocol)
    func rewards(service: RewardServiceProtocol)
}


final class ViewModel: ServiceProtocol {

    private var userService: UserServiceProtocol?
    private var rewardService: RewardServiceProtocol?

    func users(service: UserServiceProtocol) {
        self.userService = service
    }

    func rewards(service: RewardServiceProtocol) {
        self.rewardService = service
    }

}
