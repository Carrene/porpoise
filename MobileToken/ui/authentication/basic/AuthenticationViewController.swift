

import UIKit

class AuthenticationViewController: UIViewController, AuthenticationDelegate {
    
    @IBOutlet weak var vAuthenticationContainer: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getAuthentication()
    }
    
    func getAuthentication() {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                UIHelper.showFailedSnackBar()
            } else {
                if repoResponse.value?.authenticationType == 0 {
                    self?.lbTitle.text = R.string.localizable.lb_enter_password()
                    self?.embedVCPassword(authentication:repoResponse.value!)
                } else {
                    self?.lbTitle.text = R.string.localizable.lb_enter_pattern()
                    self?.embedVCPattern(authentication: repoResponse.value!)
                }
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func embedVCPassword(authentication:Authentication) {
        var vcPassword: AuthenticationPasswordViewController?
        vcPassword = R.storyboard.authentication.authenticationPasswordViewController()
        vcPassword?.setDelegate(authenticationDelegate: self)
        vcPassword?.setAuthentication(authentication: authentication)
        vcPassword?.willMove(toParent: self)
        self.addChild(vcPassword!)
        vAuthenticationContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = vAuthenticationContainer.bounds
    }
    
    func embedVCPattern(authentication:Authentication) {
        var vcPattern: AuthenticationPatternViewController?
        vcPattern = R.storyboard.authentication.authenticationPatternViewController()
        vcPattern?.setDelegate(authenticationDelegate: self)
        vcPattern?.setAuthentication(authentication: authentication)
        vcPattern?.willMove(toParent: self)
        self.addChild(vcPattern!)
        vAuthenticationContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = vAuthenticationContainer.bounds
    }
    
    func authenticationSucceed() {        
    
    }
}

