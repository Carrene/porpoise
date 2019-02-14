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
    
    var hintDataSource = [R.string.localizable.enter_at_least_eight_characters():false,R.string.localizable.enter_at_least_one_capital_letter():false,R.string.localizable.enter_at_least_one_digit():false,R.string.localizable.enter_at_least_one_special_character():false]
    
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
        //labelPasswordHint.halfTextColorChange(fullText: R.string.localizable.lb_passwordHint(), changeText: (labelPasswordHint.text?.components(separatedBy: "،").first)!)
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
//        if !checkPasswordIsValid(password: textFieldPassword.text!) {
//            textFieldConfirmPassword.isUserInteractionEnabled = false
//            textFieldConfirmPassword.text = nil
//        }
//        else {
//            textFieldConfirmPassword.isUserInteractionEnabled = true
//        }
//        if PasswordValidator.hasPasswordCapitalLetter(testStr: textFieldPassword.text!) {
//            labelPasswordHint.halfTextColorChange(fullText: R.string.localizable.lb_passwordHint(), changeText: (R.string.localizable.enter_at_least_one_capital_letter())
//        }
         if PasswordValidator.hasPasswordCapitalLetter(testStr: textFieldPassword.text!) {
            labelPasswordHint.halfTextColorChange(fullText: R.string.localizable.lb_passwordHint(), changeText: R.string.localizable.enter_at_least_one_capital_letter())
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
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.attributedText = attribute
    }
}

