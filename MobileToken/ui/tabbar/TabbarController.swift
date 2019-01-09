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
        let index = tabBarController.selectedIndex
//        if index == NSNotFound || index == 1 {
//            let navController = tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController
//            //            navController?.popToRootViewController(animated: false)
//            return
//        }
//
//        if index == NSNotFound || index == 3 {
//            let navController = tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController
//            for vc in (navController?.viewControllers)! {
//                if vc is TransactionHistoryViewController {
//                    (vc as! TransactionHistoryViewController).stateHelper = StateHelper()
//                }
//            }
//            navController?.popToRootViewController(animated: false)
//        }
    }
}
