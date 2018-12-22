

import UIKit

class AuthenticationDefinitionViewController: UIViewController, AuthenticationDefintionDelegate {
    
    @IBOutlet weak var authenticationTypeContainer: UIView!
    @IBOutlet weak var scAuthenticationType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        authenticationTypeContainer.subviews.forEach({ $0.removeFromSuperview() })
        if sender.selectedSegmentIndex == 1 {
            embedVCPassword()
        } else {
            embedVCPattern()
        }
    }
    
    func initUIComponent() {
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.hidesBackButton = true
        let attr = NSDictionary(object: R.font.iranSansMobileBold(size: 16)!, forKey: NSAttributedString.Key.font as NSCopying)
        scAuthenticationType.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any] , for: .normal)
        embedVCPattern()
    }
    
    func embedVCPassword() {
        var vcPassword: AuthenticationDefinitionPasswordViewController?
        vcPassword = R.storyboard.authenticationDefinition.authenticationDefinitionPasswordViewControllerIdentifier()
        vcPassword?.setDelegate(authenticationDefinitionDelegate: self)
        vcPassword?.willMove(toParent: self)
        self.addChild(vcPassword!)
        authenticationTypeContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = authenticationTypeContainer.bounds
    }
    
    func embedVCPattern() {
        var vcPattern: AuthenticationDefinitionPatternViewController?
        vcPattern = R.storyboard.authenticationDefinition.authenticationDefinitionPatternViewControllerIdentifier()
        vcPattern?.setDelegate(authenticationDefinitionDelegate: self)
        vcPattern?.willMove(toParent: self)
        self.addChild(vcPattern!)
        authenticationTypeContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = authenticationTypeContainer.bounds
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        navigationItem.backBarButtonItem = backItem
    }
    
    func navigateToTabbar() {
       performSegue(withIdentifier: R.segue.authenticationDefinitionViewController.authenticationDefinitionToTabbar, sender: self)
    }
    
    
}

