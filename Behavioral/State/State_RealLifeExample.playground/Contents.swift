import UIKit

class LocationTracker {
    
    private lazy var trackingState: TrackingState = EnableTrackingState(tracker: self)
    
    func startTracking() {
        trackingState.startTracking()
    }
    
    func stopTracking() {
        trackingState.stopTracking()
    }
    
    func pauseTracking(for time: TimeInterval) {
        trackingState.pauseTracking(for: time)
    }
    
    func makeCheckIn() {
        trackingState.makeCheckIn()
    }
    
    func findMyChildren() {
        trackingState.findMyChildren()
    }
    
    func update(state: TrackingState) {
        trackingState = state
    }
}

protocol TrackingState {
    
    func startTracking()
    func stopTracking()
    func pauseTracking(for time: TimeInterval)
    
    func makeCheckIn()
    func findMyChildren()
}

class EnableTrackingState: TrackingState {
    
    private weak var tracker: LocationTracker?
    
    init(tracker: LocationTracker?) {
        self.tracker = tracker
    }
    
    func startTracking() {
        print("EnabledTrackingState: StartTracking is invoked")
        print("EnabledTrackingState: tracking location...1")
        print("EnabledTrackingState: tracking location...2")
        print("EnabledTrackingState: tracking location...3")
    }
    
    func stopTracking() {
        print("EnabledTrackingState: Received 'stop tracking")
        print("EnabledTrackingState: Changing state to 'disabled'")
        tracker?.update(state: DisabledTrackingState(tracker: tracker))
        tracker?.stopTracking()
    }
    
    func pauseTracking(for time: TimeInterval) {
        print("EnabledTrackingState: Received 'pause tracking' for \(time) second")
        print("EnabledTrackingState: Changing state to 'disabled'")
        tracker?.update(state: DisabledTrackingState(tracker: tracker))
        tracker?.pauseTracking(for: time)
    }
    
    func makeCheckIn() {
        print("EnabledTrackingState: performing check-in at the current location")
    }
    
    func findMyChildren() {
        print("EnabledTrackingState: searching for children")
    }
}

class DisabledTrackingState: TrackingState {
    
    private weak var tracker: LocationTracker?
    
    init(tracker: LocationTracker?) {
        self.tracker = tracker
    }
    
    func startTracking() {
        print("DisabledTrackingState: Received 'start tracking'")
        print("DisabledTrackingState: Changing state to 'enabled'")
        tracker?.update(state: EnableTrackingState(tracker: tracker))
    }
    
    func stopTracking() {
        print("DisabledTrackingState: Received 'stop tracking'")
        print("DisabledTrackingState: Do nothing...")
    }
    
    func pauseTracking(for time: TimeInterval) {
        print("DisabledTrackingState: Pause tracking for \(time) second")
        
        for i in 0...Int(time) {
            print("DisabledTrackingState: pause...\(i)")
        }
        
        print("DisabledTrackingState: Time is over")
        print("DisabledTrackingState: Returning to 'enable state'...\n")
        tracker?.update(state: EnableTrackingState(tracker: tracker))
        tracker?.startTracking()
    }
    
    func makeCheckIn() {
        print("DisabledTrackingState: Received 'make check-in'")
        print("DisabledTrackingState: Changing state to 'enabled'...")
        tracker?.update(state: EnableTrackingState(tracker: tracker))
        tracker?.makeCheckIn()
    }
    
    func findMyChildren() {
        print("DisabledTrackingState: Received 'find my children'")
        print("DisabledTrackingState: Changing state to 'enabled'...")
        tracker?.update(state: EnableTrackingState(tracker: tracker))
        tracker?.findMyChildren()
    }
}

class StateRealWorld {
    func test() {
        
        print("Client: I'm starting working with a location tracker")
        let tracker = LocationTracker()
        
        print()
        tracker.startTracking()
        
        print()
        tracker.pauseTracking(for: 2)
        
        print()
        tracker.makeCheckIn()
        
        print()
        tracker.findMyChildren()
        
        print()
        tracker.stopTracking()
    }
}

var stateRealWorld = StateRealWorld()
stateRealWorld.test()






