import UIKit
import AMPopTip

class AuthenticationDefinitionPasswordViewController: UIViewController,UITextFieldDelegate,AuthenticationDefinitionPasswordViewProtocol {
    
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet var labelPasswordHint: UILabel!
    @IBOutlet var labelSecondPassword: UILabel!
    
    var passwordIsValid = false
    var authenticationDefinitionPasswordPresenter: AuthenticationDefinitionPasswordPresenterProtocol?
    var authenticationDefinitionDelegate: AuthenticationDefintionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationDefinitionPasswordPresenter = AuthenticationDefinitionPasswordPresenter(authenticationDefinitionPasswordView: self)
        initUIComponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func initUIComponent() {
        textFieldPassword.addTarget(self, action: #selector(self.textFieldPasswordDidChange(_:)), for: UIControl.Event.editingChanged)
        textFieldConfirmPassword.layer.cornerRadius = 5
        textFieldConfirmPassword.isUserInteractionEnabled = false
        textFieldPassword.layer.cornerRadius = 5
        textFieldPassword.layer.borderWidth = 2
        textFieldPassword.layer.borderColor = R.color.buttonColor()?.cgColor
        textFieldConfirmPassword.layer.borderWidth = 2
        textFieldConfirmPassword.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.15).cgColor
        textFieldPassword.becomeFirstResponder()
        labelPasswordHint.font = R.font.iranSansMobile(size: 12)
        labelSecondPassword.font = R.font.iranSansMobile(size: 12)
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: R.string.localizable.ph_password(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
        textFieldConfirmPassword.attributedPlaceholder = NSAttributedString(string:R.string.localizable.ph_confirm_password() ,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
    
    }
    
    func setDelegate(authenticationDefinitionDelegate: AuthenticationDefintionDelegate) {
        
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
    
    @IBAction func onEditBegin(_ sender: UITextField) {
        
    }
    
    @IBAction func onEndEditing(_ sender: UITextField) {
        
    }
    
    @IBAction func onDoneKeyboard(_ sender: Any) {
        authenticationDefinitionPasswordPresenter?.checkPasswords(password: textFieldPassword.text!, confirmpassword: textFieldConfirmPassword.text!)
    }
    
    @objc func textFieldPasswordDidChange(_ textField: UITextField) {
        var metState = [String]()
        
        if PasswordValidator.hasPasswordMinimumLength(testStr: textFieldPassword.text!) {
            metState.append(R.string.localizable.enter_at_least_eight_characters())
        }
        if PasswordValidator.hasPasswordDigit(testStr: textFieldPassword.text!) {
            metState.append(R.string.localizable.enter_at_least_one_digit())
        }
        if PasswordValidator.hasPasswordCapitalLetter(testStr: textFieldPassword.text!) {
            metState.append(R.string.localizable.enter_at_least_one_capital_letter())
        }
        if PasswordValidator.hasPasswordCustomCharacters(testStr: textFieldPassword.text!) {
            metState.append(R.string.localizable.enter_at_least_one_special_character())
        }
        
        labelPasswordHint.halfTextColorChange(fullText: R.string.localizable.lb_passwordHint(),changeText:metState )
        
        if !checkPasswordIsValid(password: textFieldPassword.text!) {
            textFieldConfirmPassword.isUserInteractionEnabled = false
            textFieldConfirmPassword.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.15).cgColor
            textFieldConfirmPassword.text = nil
        }
        else {
            textFieldConfirmPassword.isUserInteractionEnabled = true
            textFieldConfirmPassword.layer.borderColor = R.color.buttonColor()!.cgColor
        }
    }
    
    func checkPasswordIsValid(password:String) -> Bool {
    return (PasswordValidator.hasPasswordMinimumLength(testStr: textFieldPassword.text) &&
    PasswordValidator.hasPasswordDigit(testStr: textFieldPassword.text) &&
    PasswordValidator.hasPasswordCapitalLetter(testStr: textFieldPassword.text) &&
    PasswordValidator.hasPasswordCustomCharacters(testStr: textFieldPassword.text))
    }
    
    
    func showNotMatchError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_passwords_not_match(), color: R.color.errorDark()!)
        dismissKeyboard()
    }
    
    func authenticationUpdatedAction() {
        
    }
    
    func navigateToTabbar() {
        self.authenticationDefinitionDelegate?.navigateToTabbar()
    }
}

