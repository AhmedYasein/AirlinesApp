import Foundation
import CallKit

final class CallManager: NSObject {
    
    // Singleton instance
    static let shared = CallManager()
    
    // CXProvider instance for telephony interactions
    private var provider: CXProvider
    
    private override init() {
        let configuration = CXProviderConfiguration()
        configuration.ringtoneSound = "audio.mp3"
        configuration.supportsVideo = true
        configuration.includesCallsInRecents = true
        self.provider = CXProvider(configuration: configuration)
        super.init()
        self.provider.setDelegate(self, queue: nil)
    }
    
    // Reports an incoming call
    func processForIncomingCall(sender: String, uuid: UUID) {
        let handler = CXHandle(type: .generic, value: sender)
        let callUpdate = CXCallUpdate()
        callUpdate.remoteHandle = handler
        self.provider.reportNewIncomingCall(with: uuid, update: callUpdate) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension CallManager: CXProviderDelegate {
    
    // Called when the provider is reset
    func providerDidReset(_ provider: CXProvider) { }
    
    // Handles answer call action
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    // Handles end call action
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fail()
    }
}
