import UIKit
import AVFoundation
import CoreLocation
import Photos

class PermissionAccessor: CustomStringConvertible {
    
    typealias Completion = (Bool) -> ()
    
    func requestAccessIfNeeded(_ completion: @escaping Completion) {
        
        guard !hasAccess() else { completion(true); return}
        
        willReceiveAccess()
        
        requestAccess { status in
            status ? self.didReceiveAccess(): self.didRejectAccess()
        }
        
    }
    
    func requestAccess(_ completion: @escaping Completion) {
        fatalError("Should be overridden")
    }
    
    func hasAccess() -> Bool {
        fatalError("Should be overridden")
    }
    
    var description: String { return "PermissionAccessor"}
    
    // Hooks
    func willReceiveAccess() {}
    
    func didReceiveAccess() {}
    
    func didRejectAccess() {}
}

class CameraAccessor: PermissionAccessor {
    
    override func requestAccess(_ completion: @escaping Completion) {
        AVCaptureDevice.requestAccess(for: .video) { status in
            return completion(status)
        }
    }
    
    override func hasAccess() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    override var description: String { return "Microphone"}
}

class MicrophoneAccessor: PermissionAccessor {
    
    override func requestAccess(_ completion: @escaping Completion) {
        AVAudioSession.sharedInstance().requestRecordPermission { status in
            completion(status)
        }
    }
    
    override func hasAccess() -> Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted
    }
    
    override var description: String { return "Microphone" }
}

class PhotoLibraryAccessor: PermissionAccessor {
    
    override func requestAccess(_ completion: @escaping Completion) {
        PHPhotoLibrary.requestAuthorization { status in
            completion(status == .authorized)
        }
    }
    
    override func hasAccess() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == .authorized
    }
    
    override var description: String { return "PhotoLibrary" }
    
    override func didReceiveAccess() {
        /// We want to track how many people give access to the PhotoLibrary.
        print("PhotoLibrary Accessor: Receive access. Updating analytics...")
    }
    
    override func didRejectAccess() {
        /// ... and also we want to track how many people rejected access.
        print("PhotoLibrary Accessor: Rejected with access. Updating analytics...")
    }
}



//MARK: - TemplateRealWorld
class TemplateRealWorld {
    
    func testTemplateMethodReal() {
        
        let accessors = [CameraAccessor(), MicrophoneAccessor(), PhotoLibraryAccessor()]
        
        accessors.forEach { item in
            item.requestAccessIfNeeded { status in
                let message = status ? "You have access to " : "You don't have access to "
                print(message + item.description + "\n")
            }
        }
    }
}

var templateRealWorld = TemplateRealWorld()
templateRealWorld.testTemplateMethodReal()






