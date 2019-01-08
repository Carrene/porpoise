import UIKit

class AuthenticationViewController: BaseViewController, AuthenticationDelegate, AuthenticationViewProtocol {
   
    @IBOutlet weak var vAuthenticationContainer: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var authenticationPresenter: AuthenticationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationPresenter = AuthenticationPresenter(authenticationView: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authenticationPresenter?.getAuthentication()
    }
    
    func initUIComponents() {
        
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
        performSegue(withIdentifier: R.segue.authenticationViewController.authenticationToRegistration.identifier, sender: self)
    }

    func navigateToInputPhoneNumber() {
        performSegue(withIdentifier: R.segue.authenticationViewController.authenticationToCardList.identifier, sender: self)
    }

    func navigateToLockView() {
        performSegue(withIdentifier: R.segue.authenticationViewController.authenticationToApplicationLock.identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case R.segue.authenticationViewController.authenticationToCardList.identifier:
            (segue.destination as! TabBarViewController).selectedIndex = 0
        case R.segue.authenticationViewController.authenticationToRegistration.identifier:
            (segue.destination as! TabBarViewController).selectedIndex = 1
        default:
            print("error")
        }
    }
    
    
}

