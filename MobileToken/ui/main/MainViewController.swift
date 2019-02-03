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
        let alertController : UIAlertController = UIAlertController(title: NSLocalizedString("ad_root_title", comment: ""), message: nil, preferredStyle: .alert)
        alertController.view.backgroundColor = UIColor.white
        alertController.view.layer.cornerRadius = 8.0
        let user = User.load()
        if(user.getPhoneNumber() != nil && user.getPhoneNumber()?.characters.count != 0){
            
            NSLogv("Jailbreak device %@ %@", getVaList([user.getPhoneNumber()!,DeviceUtil.getDeviceName()]))
        }
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: NSLocalizedString("ad_root_message", comment: "") as String, attributes: [NSFontAttributeName:UIFont(name: "IRANSansMobile(FaNum)", size: 12.0)!])
        alertController.setValue(myMutableString, forKey: "attributedTitle")
        alertController.addAction(UIAlertAction(title: NSLocalizedString("ad_root_button", comment: ""), style: UIAlertActionStyle.default)
        { action -> Void in
            
            exit(0)}
        )
        present(alertController, animated: true, completion: nil)
    }

}
