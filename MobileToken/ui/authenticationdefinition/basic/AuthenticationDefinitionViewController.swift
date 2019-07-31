
import PopupDialog
import UIKit

class AuthenticationDefinitionViewController: BaseViewController, AuthenticationDefintionDelegate {
    
    @IBOutlet weak var labelAppDescription: UILabel!
    
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
        labelAppDescription.text = R.string.localizable.lb_raaz_description()
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
        
            let alert = PopupDialog(title:R.string.localizable.alert() , message: R.string.localizable.alert_set_timezone())
            alert.transitionStyle = .zoomIn
            alert.buttonAlignment = .horizontal
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.backgroundColor = R.color.primary()
            dialogAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
            dialogAppearance.titleColor = R.color.buttonColor()
            dialogAppearance.messageColor = R.color.buttonColor()
            dialogAppearance.messageFont = R.font.iranSansMobile(size: 14)!
        
            let containerAppearance = PopupDialogContainerView.appearance()
            containerAppearance.backgroundColor = R.color.primaryLight()
            containerAppearance.cornerRadius = 10
            
            let cancelButton = CancelButton(title: R.string.localizable.understand()) {
                print("You canceled the dialog.")
            }
        
            var cancelButtonAppearance = CancelButton.appearance()
            cancelButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
            cancelButtonAppearance.titleColor = R.color.primary()
            cancelButtonAppearance.separatorColor = R.color.secondary()?.withAlphaComponent(0.25)
            cancelButtonAppearance.buttonColor = R.color.secondary()
        
        
            alert.addButtons([cancelButton])
            
            self.present(alert, animated: true, completion: nil)
            
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

