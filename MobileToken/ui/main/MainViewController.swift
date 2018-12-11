

import UIKit

class MainViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToTabbar()
        

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let onIntroEnd = { [weak self] in
//
//            UIApplication.shared.statusBarStyle = .default
//
//        }
//        let introVC = IntroViewController.newInstance(withIntroEndAction: onIntroEnd)
//        present(introVC, animated: true, completion: nil)
//    }
    
    
    
    func navigateToAuthentication() {
        performSegue(withIdentifier: R.segue.mainViewController.navigateToAuthentication.identifier, sender: self)
    }

    func navigatoToAuthenticationDefinition() {
        performSegue(withIdentifier: R.segue.mainViewController.navigatoToAuthenticationDefinition.identifier, sender: self)
    }

    func navigateToTabbar() {
        performSegue(withIdentifier: R.segue.mainViewController.navigateToTabbar.identifier, sender: self)
    }
    
    func navigateToImportToken() {
        performSegue(withIdentifier: R.segue.mainViewController.navigatoToImportToken.identifier, sender: self)
    }

}
