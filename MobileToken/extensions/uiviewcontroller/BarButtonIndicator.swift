import Foundation
import UIKit

extension UIViewController {
    func startBarButtonRightIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.color = .gray
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        activityIndicator.startAnimating()
    }
    
    func stopBarButtonRightIndicator(btNavigationRight: UIBarButtonItem, activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        navigationItem.setRightBarButton(btNavigationRight, animated: true)
    }
}
