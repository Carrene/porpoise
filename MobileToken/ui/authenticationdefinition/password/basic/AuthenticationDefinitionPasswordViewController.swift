
protocol AuthenticationDefintionDelegate:class {
    func authenticationSucceed(authentication:Authentication)
}

import UIKit
import PasswordTextField
import AMPopTip

class AuthenticationDefinitionPasswordViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textFieldPassword: PasswordTextField!
    @IBOutlet weak var textFieldConfirmPassword: PasswordTextField!
    @IBOutlet var buttonConfirm: UIButton!
    
    var passwordHint = PopTip()
    var passwordIsValid = false
    var passwordHintAdapter : PasswordHintTableAdapter?
    var passwordHintTableView : UITableView?
    var hintDataSource = [R.string.localizable.enter_at_least_eight_characters():false,R.string.localizable.enter_at_least_one_capital_letter():false,R.string.localizable.enter_at_least_one_digit():false,R.string.localizable.enter_at_least_one_special_character():false]

    var authenticationDefinitionDelegate: AuthenticationDefintionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPasswordHintTable()
        initUIComponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
                 
    func initUIComponent() {
        self.hideKeyboardWhenTappedAround()
        textFieldPassword.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        textFieldConfirmPassword.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        textFieldConfirmPassword.isUserInteractionEnabled = false
        textFieldConfirmPassword.cornerRadius = 5
        textFieldPassword.cornerRadius = 5
        passwordHint.shouldDismissOnTapOutside = false
        passwordHint.shouldDismissOnTap = false
        passwordHint.shouldDismissOnSwipeOutside = false
        textFieldPassword.becomeFirstResponder()
        buttonConfirm.layer.cornerRadius = 5
        buttonConfirm.isEnabled = false
        buttonConfirm.setTitleColor(R.color.buttonColor()?.withAlphaComponent(0.2), for: .disabled)
        buttonConfirm.backgroundColor = R.color.secondary()?.withAlphaComponent(0.2)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func initPasswordHintTable() {
        passwordHintTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 315, height: 119))
        passwordHintTableView?.layer.cornerRadius = 5
        passwordHintTableView?.backgroundColor = R.color.primary()
        self.passwordHintTableView?.register(R.nib.passwordHintTableViewCell)
        passwordHintAdapter = PasswordHintTableAdapter()
        passwordHintTableView?.delegate = passwordHintAdapter
        passwordHintTableView?.dataSource = passwordHintAdapter
        passwordHintAdapter?.setDataSource(hintDataSource: hintDataSource)
        passwordHint.bubbleColor = R.color.primary()!
        passwordHint.borderColor = UIColor.clear
        passwordHintTableView?.allowsSelection = false
        passwordHintTableView?.reloadData()
    }
    
    func setDelegate(authenticationDefinitionDelegate: AuthenticationDefintionDelegate) {
        
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
   
    
    @IBAction func onEditBegin(_ sender: PasswordTextField) {
        passwordHint.show(customView: passwordHintTableView!, direction: .down, in: view, from: (textFieldPassword.frame))
    }
    
   
    
    @IBAction func onEndEditing(_ sender: PasswordTextField) {
        passwordHint.hide()
    }
   
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if PasswordValidator.hasPasswordMinimumLength(testStr: textFieldPassword.text) != hintDataSource[R.string.localizable.enter_at_least_eight_characters()] {
            
            hintDataSource.updateValue(PasswordValidator.hasPasswordMinimumLength(testStr: textFieldPassword.text), forKey: R.string.localizable.enter_at_least_eight_characters())
            passwordHintTableView?.reloadData()
        }
        
        if PasswordValidator.hasPasswordCapitalLetter(testStr: textFieldPassword.text)  != hintDataSource[R.string.localizable.enter_at_least_one_capital_letter()]{
            
            hintDataSource.updateValue(PasswordValidator.hasPasswordCapitalLetter(testStr: textFieldPassword.text), forKey: R.string.localizable.enter_at_least_one_capital_letter())
            passwordHintTableView?.reloadData()
        }
        
        if PasswordValidator.hasPasswordDigit(testStr: textFieldPassword.text) != hintDataSource[R.string.localizable.enter_at_least_one_digit()] {
            
            hintDataSource.updateValue(PasswordValidator.hasPasswordDigit(testStr: textFieldPassword.text), forKey:R.string.localizable.enter_at_least_one_digit())
            passwordHintTableView?.reloadData()
        }
        
        if PasswordValidator.hasPasswordCustomCharacters(testStr: textFieldPassword.text) != hintDataSource[R.string.localizable.enter_at_least_one_special_character()] {
            
            hintDataSource.updateValue(PasswordValidator.hasPasswordCustomCharacters(testStr: textFieldPassword.text), forKey:R.string.localizable.enter_at_least_one_special_character())
            passwordHintTableView?.reloadData()
        }
        
        passwordHintAdapter?.setDataSource(hintDataSource: hintDataSource)
        passwordIsValid = !hintDataSource.values.contains(false)
        
        if passwordIsValid == false {
            
            textFieldConfirmPassword.isUserInteractionEnabled = false
            textFieldConfirmPassword.text = nil
        }
        else {
            
            textFieldConfirmPassword.isUserInteractionEnabled = true
            if textField == textFieldConfirmPassword {
                
                guard (textFieldPassword.text?.hasPrefix(textField.text!))! else {
                    UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_not_match(), color: R.color.errorColor()!)
                    return
                }
                if textFieldConfirmPassword.text == textFieldPassword.text {
                    buttonConfirm.isEnabled = true
                    buttonConfirm.backgroundColor = R.color.secondary()
                    let authentication = Authentication(credentials: textFieldPassword.text, authenticationType: 0)
                    authenticationDefinitionDelegate?.authenticationSucceed(authentication: authentication)
                }
            }
        }
    }
}

