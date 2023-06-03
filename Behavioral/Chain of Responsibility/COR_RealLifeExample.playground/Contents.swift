import UIKit
import Foundation

protocol Handler {
    var next: Handler? { get }
    func handle(_ request: Request) -> LocalizedError?
}

class BaseHandler: Handler {
    var next: Handler?
    
    init(with handler: Handler? = nil) {
        self.next = handler
    }
    
    func handle(_ request: Request) -> LocalizedError? {
        return next?.handle(request)
    }
}

class LoginHandler: BaseHandler {
    override func handle(_ request: Request) -> LocalizedError? {
        
        guard request.email?.isEmpty == false else {
            return AuthError.emptyEmail
        }
        
        guard request.password?.isEmpty == false else {
            return AuthError.emptyPassword
        }
        
        return next?.handle(request)
    }
}

class SignUpHandler: BaseHandler {

    private struct Limit {
        static let passwordLength = 8
    }

    override func handle(_ request: Request) -> LocalizedError? {

        guard request.email?.contains("@") == true else {
            return AuthError.invalidEmail
        }

        guard (request.password?.count ?? 0) >= Limit.passwordLength else {
            return AuthError.invalidPassword
        }

        guard request.password == request.repeatedPassword else {
            return AuthError.differentPasswords
        }

        return next?.handle(request)
    }
}

class LocationHandler: BaseHandler {
    override func handle(_ request: Request) -> LocalizedError? {
        guard isLocationEnabled() else {
            return AuthError.locationDisabled
        }
        return next?.handle(request)
    }

    func isLocationEnabled() -> Bool {
        return true /// Calls special method
    }
}

class NotificationHandler: BaseHandler {
    override func handle(_ request: Request) -> LocalizedError? {
        guard isNotificationsEnabled() else {
            return AuthError.notificationsDisabled
        }
        return next?.handle(request)
    }

    func isNotificationsEnabled() -> Bool {
        return false /// Calls special method
    }
}

protocol Request {
    var firstName: String? { get }
    var lastName: String? { get }

    var email: String? { get }
    var password: String? { get }
    var repeatedPassword: String? { get }
}

extension Request {
    var firstName: String? { return nil }
    var lastName: String? { return nil }

    var email: String? { return nil }
    var password: String? { return nil }
    var repeatedPassword: String? { return nil }

}

struct SignUpRequest: Request {
    var firstName: String?
    var lastName: String?

    var email: String?
    var password: String?
    var repeatedPassword: String?
}

struct LoginRequest: Request {
    var email: String?
    var password: String?
}

protocol AuthHandlerSupportable: AnyObject {
    var handler: Handler? { get set }
}

enum AuthError: LocalizedError {

    case emptyFirstName
    case emptyLastName

    case emptyEmail
    case emptyPassword

    case invalidEmail
    case invalidPassword
    case differentPasswords

    case locationDisabled
    case notificationsDisabled

    var errorDescription: String? {
        switch self {
        case .emptyFirstName:
            return "First name is empty"
        case .emptyLastName:
            return "Last name is empty"
        case .emptyEmail:
            return "Email is empty"
        case .emptyPassword:
            return "Password is empty"
        case .invalidEmail:
            return "Email is invalid"
        case .invalidPassword:
            return "Password is invalid"
        case .differentPasswords:
            return "Password and repeated password should be equal"
        case .locationDisabled:
            return "Please turn location services on"
        case .notificationsDisabled:
            return "Please turn notifications on"
        }
    }
}

class BaseAuthVC: AuthHandlerSupportable {
    var handler: Handler?
    
    init(handler: Handler) {
        self.handler = handler
    }
}

class LoginVC: BaseAuthVC {
    func loginButtonSelected() {
        print("Login View Controller: User selected Login button")
        
        let request = LoginRequest(email: "smth@gmail.com", password: "123HardPass")
        
        if let error = handler?.handle(request) {
            print("Login View Controller: Something went wrong")
            print("Login View Controller: Error ->" + (error.errorDescription ?? ""))
        } else {
            print("Login View Controller: preconditions are successfully validated")
        }
    }
}

class SignUpViewController: BaseAuthVC {
    func signUpButtonSelected() {
        print("SignUp View Controller: User selected SignUp button")
        
        let request = SignUpRequest(firstName: "Vasya",
                                    lastName: "Pupkin",
                                    email: "vasya.pupkin@gmail.com",
                                    password: "123HardPass",
                                    repeatedPassword: "123HardPass")
        
        if let error = handler?.handle(request) {
            print("SignUp View Controller: something went wrong")
            print("SignUp View Controller: Error -> " + (error.errorDescription ?? ""))
        } else {
            print("SignUp View Controller: Preconditions are successfully validated")
        }
    }
}

class ChainOfResponsiblityRealWorld {
    func testChainOfResponsiblityRealWorld() {
        print("Client: Let's test Login flow!")
        
        let loginHandler = LoginHandler(with: LocationHandler())
        let loginController = LoginVC(handler: loginHandler)
        
        loginController.loginButtonSelected()
        
        print("\nClient: Let's test Signup flow")
        
        let signupHandler = SignUpHandler(with: LocationHandler(with: NotificationHandler()))
        let signupController = SignUpViewController(handler: signupHandler)
        
        signupController.signUpButtonSelected()
    }
}




