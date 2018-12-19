

import UIKit

class AuthenticationViewController: UIViewController, AuthenticationDelegate, AuthenticationViewProtocol {
    
    
    
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
    
    func setAuthentication(label: String) {
        self.lbTitle.text = label
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
    //TODO: Move to presenter
    func navigateToCardList() {
//        performSegue(withIdentifier: R.segue.mobileTokenAuthenticationViewController.authenticationToCardList.identifier, sender: self)
    }

    func navigateToProvisioning() {
//        performSegue(withIdentifier:R.segue.mobileTokenAuthenticationViewController.authenticationToProvisioning.identifier, sender: self)
    }

    func navigateToLockView() {
        vAuthenticationContainer.subviews.forEach({ $0.removeFromSuperview() })
        self.lbTitle.text = "lb_recived_to_max_attempt"
    }
}

