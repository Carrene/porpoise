import UIKit
import PasswordTextField

class SettingAuthenticationDefinitionPasswordViewController: UIViewController,UITextFieldDelegate,SettingAuthenticationDefinitionPasswordViewProtocol {
    
    @IBOutlet weak var textFieldPassword: PasswordTextField!
    @IBOutlet weak var textFieldConfirmPassword: PasswordTextField!
    @IBOutlet var labelPasswordHint: UILabel!
    @IBOutlet var labelSecondPassword: UILabel!
    
    var passwordIsValid = false
    var authenticationDefinitionPasswordPresenter: SettingAuthenticationDefinitionPasswordPresenterProtocol?
    var authenticationDefinitionDelegate: SettingAuthenticationDefintionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationDefinitionPasswordPresenter = SettingAuthenticationDefinitionPasswordPresenter(authenticationDefinitionPasswordView: self)
        initUIComponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func initUIComponent() {
        textFieldPassword.addTarget(self, action: #selector(self.textFieldPasswordDidChange(_:)), for: UIControl.Event.editingChanged)
        textFieldConfirmPassword.addTarget(self, action: #selector(self.textFieldConfirmPasswordDidChange(_:)), for: UIControl.Event.editingChanged)
        textFieldConfirmPassword.layer.cornerRadius = 5
        textFieldConfirmPassword.isUserInteractionEnabled = false
        textFieldPassword.layer.cornerRadius = 5
        textFieldPassword.layer.borderWidth = 1
        textFieldPassword.layer.borderColor = R.color.buttonColor()?.cgColor
        textFieldConfirmPassword.layer.borderWidth = 1
        textFieldConfirmPassword.layer.borderColor = R.color.buttonColor()?.cgColor
        textFieldPassword.becomeFirstResponder()
        labelPasswordHint.font = R.font.iranSansMobile(size: 12)
        labelSecondPassword.font = R.font.iranSansMobile(size: 12)
        labelPasswordHint.textColor = R.color.buttonColor()
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: R.string.localizable.ph_password(),
                                                                     attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
        textFieldConfirmPassword.attributedPlaceholder = NSAttributedString(string:R.string.localizable.ph_confirm_password() ,
                                                                            attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
        
    }
    
    func setDelegate(authenticationDefinitionDelegate: SettingAuthenticationDefintionDelegate) {
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
    
    @IBAction func editBegin(_ sender: UITextField) {
        
    }
    
    @IBAction func onEndEditing(_ sender: UITextField) {
        
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
            textFieldConfirmPassword.text = nil
        }
        else {
            textFieldConfirmPassword.isUserInteractionEnabled = true
        }
    }
    
    
    
    func checkPasswordIsValid(password:String) -> Bool {
        return (PasswordValidator.hasPasswordMinimumLength(testStr: textFieldPassword.text) &&
            PasswordValidator.hasPasswordDigit(testStr: textFieldPassword.text) &&
            PasswordValidator.hasPasswordCapitalLetter(testStr: textFieldPassword.text) &&
            PasswordValidator.hasPasswordCustomCharacters(testStr: textFieldPassword.text))
    }
    
    
    @objc func textFieldConfirmPasswordDidChange(_ textField: UITextField) {
        authenticationDefinitionPasswordPresenter?.checkPasswords(password: textFieldPassword.text!, confirmpassword: textFieldConfirmPassword.text!)
    }
    
    func showNotMatchError() {
        
    }
    
    func authenticationUpdatedAction() {
        
    }               
}

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : [String] ) {
        
        let attributedString = NSMutableAttributedString.init(string: fullText)
        for highlightedWord in changeText {
            let textRange = (fullText as NSString).range(of: highlightedWord)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: R.color.secondary()! , range: textRange)
        }
        self.attributedText = attributedString
    }
}



