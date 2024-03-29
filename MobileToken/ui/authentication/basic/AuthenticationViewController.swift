import UIKit

class AuthenticationViewController: BaseViewController, AuthenticationDelegate, AuthenticationViewProtocol {
   
    @IBOutlet weak var vAuthenticationContainer: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var labelAppDescription: UILabel!
    var authenticationPresenter: AuthenticationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationPresenter = AuthenticationPresenter(authenticationView: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authenticationPresenter?.getAuthentication()
    }
    
    func initUIComponents() {
        labelAppDescription.text = R.string.localizable.lb_raaz_description()
    }
    
    func initListeners() {
        
    }
    
    
    func embedVCPassword(authentication:Authentication) {
        var vcPassword: AuthenticationPasswordViewController?
        vcPassword = R.storyboard.authentication.authenticationPasswordViewController()
        vcPassword?.setDelegate(authenticationDelegate: self)
        vcPassword?.willMove(toParent: self)
        self.addChild(vcPassword!)
        vAuthenticationContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = vAuthenticationContainer.bounds
    }
    
    func embedVCPattern(authentication:Authentication) {
        var vcPattern: AuthenticationPatternViewController?
        vcPattern = R.storyboard.authentication.authenticationPatternViewController()
        vcPattern?.setDelegate(authenticationDelegate: self)
        vcPattern?.willMove(toParent: self)
        self.addChild(vcPattern!)
        vAuthenticationContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = vAuthenticationContainer.bounds
    }
    func navigateToCardList() {
        
        
        let appLocked = ScreenLocker.isAutoLocked
        if appLocked {
            self.dismiss(animated: false, completion: nil)
            ScreenLocker.isAutoLocked = false
        } else {
            performSegue(withIdentifier: R.segue.authenticationViewController.authenticationToRegistration.identifier, sender: self)
            
        }
    
    }

    func navigateToInputPhoneNumber() {

        let appLocked  = ScreenLocker.isAutoLocked
        if appLocked {
            self.dismiss(animated: false, completion: nil)
            ScreenLocker.isAutoLocked = false
        } else {
            performSegue(withIdentifier: R.segue.authenticationViewController.authenticationToCardList.identifier, sender: self)
        }
        
    }

    func navigateToLockView() {
        performSegue(withIdentifier: R.segue.authenticationViewController.authenticationToApplicationLock.identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case R.segue.authenticationViewController.authenticationToCardList.identifier:
            let destination = segue.destination as! TabBarViewController
            destination.selectedIndex = 0
        case R.segue.authenticationViewController.authenticationToRegistration.identifier:
            let destination = segue.destination as! TabBarViewController
            destination.selectedIndex = 1
        default:
            print("error")
        }
    }
    
    
}

