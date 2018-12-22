import UIKit

class MainViewController: UINavigationController {

    var flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if flag == 0 {
        intro()
        }
    }
    
    func intro() {
        let onIntroEnd = { [weak self] in
            self!.navigatoToAuthenticationDefinition()
        }
        let introVC = IntroViewController.newInstance(withIntroEndAction: onIntroEnd)
        present(introVC, animated: true, completion: nil)
        flag = 1
    }
    
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
