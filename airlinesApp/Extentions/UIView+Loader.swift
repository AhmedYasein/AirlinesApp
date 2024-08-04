import Foundation
import UIKit

extension UIView {
    
    // setup Activity indicator on the view
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = self.bounds
        activityIndicator.center = self.center
        activityIndicator.style = .large
        activityIndicator.tag = 333
        return activityIndicator
    }
    
    // Shows a loading indicator on the view
    func showLoading() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    // Hides the loading indicator from the view
    func hideLoading() {
        if let activityIndicator = viewWithTag(333) {
            activityIndicator.removeFromSuperview()
        }
    }
}
