

import UIKit

class AuthenticationDefinitionViewController: BaseViewController, AuthenticationDefintionDelegate {
    
    
    @IBOutlet weak var authenticationTypeContainer: UIView!
    @IBOutlet weak var scAuthenticationType: UISegmentedControl!
    private var hasAlertShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        authenticationTypeContainer.subviews.forEach({ $0.removeFromSuperview() })
        if sender.selectedSegmentIndex == 1 {
            embedVCPassword()
        } else {
            embedVCPattern()
        }
    }
    
    
    func initUIComponents() {
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.hidesBackButton = true
        let attr = NSDictionary(object: R.font.iranSansMobileBold(size: 16)!, forKey: NSAttributedString.Key.font as NSCopying)
        scAuthenticationType.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any] , for: .normal)
        scAuthenticationType.layer.cornerRadius = 10
        embedVCPattern()
        if !UserDefaults.standard.bool(forKey: "hasAlertShown") {
        timeZoneAlert()
        }
    }
    
    func timeZoneAlert() {
        UserDefaults.standard.set(true, forKey: "hasAlertShown")
        
        let attributedString = NSAttributedString(string: R.string.localizable.alert_set_timezone(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobile(size: 16)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!
            ])
        
        let alert = UIAlertController(title: "", message: R.string.localizable.alert_set_timezone(), preferredStyle: .alert)
        
        alert.setValue(attributedString, forKey: "attributedMessage")
            
        
        let okAction = UIAlertAction(title: R.string.localizable.ok() , style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion:{})
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 10
        subview.backgroundColor = R.color.primaryLight()
    }
    
    func initListeners() {
        
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
        
    }
    
    func navigateToTabbar() {
       performSegue(withIdentifier: R.segue.authenticationDefinitionViewController.authenticationDefinitionToTabbar, sender: self)
    }
    
    
}

