import Foundation

// Clients should not be forced to depend upon interfaces that they do not use

protocol GestureProtocol {
    func didTap()
    func didDoubleTap()
    func didLongPress()
}

// Our SuperButton is happy to implement the methods which it needs.

class SuperButton: GestureProtocol {
    func didTap() {
        // send tap action
    }

    func didDoubleTap() {
        // send double tap action
    }

    func didLongPress() {
        // send long press action
    }
}

// The problem is that our app has also a PoorButton which needs just didTap. It must implement methods which it doesn’t need, breaking ISP.

class PoorButton: GestureProtocol {
    func didTap() {
        // send tap action
    }

    func didDoubleTap() { }

    func didLongPress() { }
}

//We can solve the problem using little protocols instead of a big one.

protocol TapProtocol {
    func didTap()
}

protocol DoubleTapProtocol {
    func didDoubleTap()
}

protocol LongPressProtocol {
    func didLongPress()
}

class ISSuperButton: TapProtocol, DoubleTapProtocol, LongPressProtocol {
    func didTap() {
        // send tap action
    }

    func didDoubleTap() {
        // send double tap action
    }

    func didLongPress() {
        // send long press action
    }
}

class ISPoorButton: TapProtocol {
    func didTap() {
        // send tap action
    }
}
