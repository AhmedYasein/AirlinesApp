import Foundation
import CallKit
import AVFoundation

final class CallManager: NSObject {
    // Singleton instance
    static let shared = CallManager()
    
    // CXProvider instance
    private var provider: CXProvider
    
    // CallController instance
    private let callController = CXCallController()
    
    private override init() {
        let configuration = CXProviderConfiguration(localizedName: "AirlinesApp")
        configuration.ringtoneSound = "ringtone.caf" // Replace with your own sound file
        configuration.supportsVideo = true
        configuration.includesCallsInRecents = true
        configuration.supportedHandleTypes = [.phoneNumber]
        
        self.provider = CXProvider(configuration: configuration)
        
        super.init()
        self.provider.setDelegate(self, queue: nil)
    }
    
    func reportIncomingCall(uuid: UUID, handle: String, hasVideo: Bool = false) {
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: handle)
        update.hasVideo = hasVideo
        
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            if let error = error {
                print("Failed to report incoming call: \(error.localizedDescription)")
            } else {
                print("Incoming call successfully reported")
            }
        }
    }
    
    func startCall(handle: String, videoEnabled: Bool = false) {
        let handle = CXHandle(type: .phoneNumber, value: handle)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
        startCallAction.isVideo = videoEnabled
        
        let transaction = CXTransaction(action: startCallAction)
        
        callController.request(transaction) { error in
            if let error = error {
                print("Failed to start call: \(error.localizedDescription)")
            } else {
                print("Call successfully started")
            }
        }
    }
}

extension CallManager: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        // Handle provider reset
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        // Perform necessary steps to answer the call
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        // Perform necessary steps to end the call
        action.fulfill()
    }
}
