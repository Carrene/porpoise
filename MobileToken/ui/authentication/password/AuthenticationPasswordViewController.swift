
import UIKit
import PasswordTextField

class AuthenticationPasswordViewController: UIViewController, UITextFieldDelegate, AuthenticationPasswordViewProtocol {
    
    @IBOutlet var textFieldPassword: UITextField!
    
    var authenticationDelegate: AuthenticationDelegate?
    private var authentication: Authentication?
    var authenticationPasswordPresenter: AuthenticationPasswordPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationPasswordPresenter = AuthenticationPasswordPresenter(authenticationPasswordView: self)
        initUIComponent()
    }
    
    func setDelegate(authenticationDelegate:AuthenticationDelegate) {
        self.authenticationDelegate = authenticationDelegate
    }
    
    func initUIComponent() {
        textFieldPassword.delegate = self
        textFieldPassword.becomeFirstResponder()
        textFieldPassword.layer.borderColor = R.color.buttonColor()?.cgColor
        textFieldPassword.layer.borderWidth = 1
        textFieldPassword.layer.cornerRadius = 5
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "رمز برنامه",
                                                             attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
    }
    
    @IBAction func textFieldPasswordEditingChanged(_ sender: UITextField) {
       
    }
    
    @IBAction func onEditDidEnd(_ sender: UITextField) {
         self.authenticationPasswordPresenter?.checkPasswordCorrection(password: sender.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.authenticationPasswordPresenter?.checkPasswordCorrection(password: textField.text!)
        self.dismissKeyboard()
        return true
    }
    
    func showWrongPasswordError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_wrong_password(), color: R.color.errorColor()!)
    }
    
    func navigateToCardList() {
        self.authenticationDelegate?.navigateToCardList()
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_successfully_done(), color: R.color.eyeCatching()!)
    }
    
    func navigateToInputPhoneNumber() {
        self.authenticationDelegate?.navigateToInputPhoneNumber()
    }
    
    func navigateToLockView() {
        self.authenticationDelegate?.navigateToLockView()
    }
}
