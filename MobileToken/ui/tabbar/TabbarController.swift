import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        self.delegate = self
//        lockAppCallBack()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lockAppCallBack()
    }
    
    func lockAppCallBack() {
        let callBack = {
            self.view.endEditing(false)
            let myModalViewController = R.storyboard.authentication.authenticationViewController()
            ScreenLocker.isAutoLocked = true
            myModalViewController!.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            myModalViewController!.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.present(myModalViewController!, animated: true, completion: nil)
        }
        AuthenticationPatternPresenter.initScreenLocker(callBack: callBack)
    }
   
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
       
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
