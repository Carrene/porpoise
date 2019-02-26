import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        self.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let callBack = {
            let myModalViewController = R.storyboard.authentication.authenticationViewController()
            ScreenLocker.isAutoLocked = true
            myModalViewController!.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            myModalViewController!.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.present(myModalViewController!, animated: true, completion: nil)
        }
        AuthenticationPatternPresenter.initScreenLocker(callBack: callBack)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
