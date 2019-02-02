

import UIKit
import PasswordTextField
import AMPopTip

class SettingAuthenticationDefinitionPasswordViewController: UIViewController,UITextFieldDelegate,SettingAuthenticationDefinitionPasswordViewProtocol {
    
    @IBOutlet weak var textFieldPassword: PasswordTextField!
    @IBOutlet weak var textFieldConfirmPassword: PasswordTextField!
    @IBOutlet var buttonConfirm: UIButton!
    
    var passwordHint = PopTip()
    var passwordIsValid = false
    var passwordHintAdapter : PasswordHintTableAdapter?
    var passwordHintTableView : UITableView?
    var authenticationDefinitionPasswordPresenter: SettingAuthenticationDefinitionPasswordPresenterProtocol?
    
    var authenticationDefinitionDelegate: SettingAuthenticationDefintionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationDefinitionPasswordPresenter = SettingAuthenticationDefinitionPasswordPresenter(authenticationDefinitionPasswordView: self)
        initPasswordHintTable()
        initUIComponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func initUIComponent() {
        self.hideKeyboardWhenTappedAround()
        textFieldPassword.addTarget(self, action: #selector(self.textFieldPasswordDidChange(_:)), for: UIControl.Event.editingChanged)
        textFieldConfirmPassword.addTarget(self, action: #selector(self.textFieldConfirmPasswordDidChange(_:)), for: UIControl.Event.editingChanged)
        textFieldConfirmPassword.isUserInteractionEnabled = false
        textFieldConfirmPassword.cornerRadius = 5
        textFieldPassword.cornerRadius = 5
        passwordHint.shouldDismissOnTapOutside = false
        passwordHint.shouldDismissOnTap = false
        passwordHint.shouldDismissOnSwipeOutside = false
        textFieldPassword.becomeFirstResponder()
        
        //buttonConfirm.layer.cornerRadius = 5
        //buttonConfirm.isEnabled = false
        //buttonConfirm.setTitleColor(R.color.buttonColor()?.withAlphaComponent(0.2), for: .disabled)
        //buttonConfirm.backgroundColor = R.color.secondary()?.withAlphaComponent(0.2)
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
        passwordHint.bubbleColor = R.color.primary()!
        passwordHint.borderColor = UIColor.clear
        passwordHintTableView?.allowsSelection = false
        passwordHintTableView?.reloadData()
    }
    
    func setDelegate(authenticationDefinitionDelegate: SettingAuthenticationDefintionDelegate) {
        
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
    @IBAction func editBegin(_ sender: PasswordTextField) {
         passwordHint.show(customView: passwordHintTableView!, direction: .down, in: view, from: (textFieldPassword.frame))
    }
    
   
    
    @IBAction func onEndEditing(_ sender: PasswordTextField) {
        passwordHint.hide()
    }
    
    
    @objc func textFieldPasswordDidChange(_ textField: UITextField) {
        passwordHintAdapter?.resetValidation()
        passwordHintAdapter!.setMinimumLengthValid(isValid: (authenticationDefinitionPasswordPresenter?.hasMinimumLength(password: textFieldPassword.text!))!)
        passwordHintAdapter!.setCapitalLetterValid(isValid: (authenticationDefinitionPasswordPresenter?.hasCapitalLetter(password: textFieldPassword.text!))!)
        passwordHintAdapter!.setHasDigit(isValid: (authenticationDefinitionPasswordPresenter?.hasDigit(password: textFieldPassword.text!))!)
        passwordHintAdapter!.setSpecialCharacterValid(isValid: (authenticationDefinitionPasswordPresenter?.hasSpecialCharacters(password: textFieldPassword.text!))!)
        passwordHintTableView?.reloadData()
        
        if passwordHintAdapter?.isCompleted() == false {
            textFieldConfirmPassword.isUserInteractionEnabled = false
            textFieldConfirmPassword.text = nil
        }
        else {
            passwordHint.hide()
            textFieldConfirmPassword.isUserInteractionEnabled = true
        }
    }
    
    @objc func textFieldConfirmPasswordDidChange(_ textField: UITextField) {
        authenticationDefinitionPasswordPresenter?.checkPasswords(password: textFieldPassword.text!, confirmpassword: textFieldConfirmPassword.text!)
    }
    
    func showNotMatchError() {
        //buttonConfirm.isEnabled = false
    }
    
    func authenticationUpdatedAction() {
        //uttonConfirm.isEnabled = true
        //buttonConfirm.backgroundColor = R.color.secondary()
    }               
}

