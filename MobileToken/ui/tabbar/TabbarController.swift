import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    //public static let STORYBOARD_ID = "TabBarVC".localized()
    override func viewDidLoad() {
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
