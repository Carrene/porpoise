import UIKit
import DTTJailbreakDetection

class MainViewController: UINavigationController {

    var hasWizardShown = false
    var authentication : Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfNewUser()
        initPages()
    }
   
    func initPages() {
        if DTTJailbreakDetection.isJailbroken() {
            sendJailBrokenDeviceToServer()
        }
        else{
            if authentication == nil {
                if UserDefaults.standard.bool(forKey: "hasWizardShown") {
                    navigatoToAuthenticationDefinition()
                }
                else {
                    intro()
                }
            }
            else {
                navigateToAuthentication()
            }
        }
    }
    
    func checkIfNewUser()  {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ())  = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("error")
            } else {
                self?.authentication = repoResponse.value
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func intro() {
        let onIntroEnd = { [weak self] in
            
        }
        let introVC = IntroViewController.newInstance(withIntroEndAction: onIntroEnd)
        present(introVC, animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "hasWizardShown")
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.mainViewController.navigateToTabbar.identifier {
            (segue.destination as! TabBarViewController).selectedIndex = 1
        }
    }
    
    fileprivate func sendJailBrokenDeviceToServer() {
        
        let attributedString = NSAttributedString(string: R.string.localizable.alert_root_message(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobile(size: 16)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!
            ])
        
        let alert = UIAlertController(title:"", message: R.string.localizable.alert_root_message(), preferredStyle: .alert)
        
        alert.setValue(attributedString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: R.string.localizable.ok(), style: .destructive, handler: 
        { (action : UIAlertAction!) -> Void in
            exit(0)}
        ))
        
        self.present(alert, animated: true, completion:{})
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 10
        subview.backgroundColor = R.color.primaryLight()
    }

}
