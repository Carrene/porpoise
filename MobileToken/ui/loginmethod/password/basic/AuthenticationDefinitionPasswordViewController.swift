//
//  AuthenticationDefinitionPasswordViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//


protocol AuthenticationDefintionDelegate:class {
    func authenticationSucceed(authentication:Authentication)
}

import UIKit
import PasswordTextField
import AMPopTip

class AuthenticationDefinitionPasswordViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var tfPasscode: PasswordTextField!
    @IBOutlet weak var tfConfirmPasscode: PasswordTextField!
    var passwordHint = PopTip()
    var passwordIsValid = false
    var passwordHintAdapter : PasswordHintTableAdapter?
    var passwordHintTableView : UITableView?
    var hintDataSource = ["enter_at_least_eight_characters".localized():false,"enter_at_least_one_capital_letter".localized():false,"enter_at_least_one_digit".localized():false,"enter_at_least_one_special_character".localized():false]
    public static let IDENTIFIER = "Authentication_Definition_Password_VC".localized()
    var authenticationDefinitionDelegate: AuthenticationDefintionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPasswordHintTable()
        initUiComponent()
    }
                 
    func initUiComponent() {
        self.hideKeyboardWhenTappedAround()
        tfPasscode.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tfConfirmPasscode.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tfConfirmPasscode.isUserInteractionEnabled = false
        tfPasscode.borderWidth = 1
        tfConfirmPasscode.borderWidth = 1
        tfConfirmPasscode.cornerRadius = 5
        tfPasscode.cornerRadius = 5
        tfConfirmPasscode.layer.borderColor = UIColorHelper.primaryLightColor.cgColor
        tfPasscode.layer.borderColor = UIColorHelper.primaryLightColor.cgColor
        passwordHint.shouldDismissOnTapOutside = false
        passwordHint.shouldDismissOnTap = false
        passwordHint.shouldDismissOnSwipeOutside = false
        tfPasscode.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func initPasswordHintTable() {
        passwordHintTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        passwordHintTableView?.backgroundColor = UIColorHelper.primaryColor
        self.passwordHintTableView?.register(R.nib.passwordHintTableViewCell)
        passwordHintAdapter = PasswordHintTableAdapter(sender: self)
        passwordHintTableView?.delegate = passwordHintAdapter
        passwordHintTableView?.dataSource = passwordHintAdapter
        passwordHintAdapter?.setDataSource(hintDataSource: hintDataSource)
        
        passwordHint.bubbleColor = UIColorHelper.primaryLightColor
        passwordHintTableView?.allowsSelection = false
        passwordHintTableView?.reloadData()
    }
    
    func setDelegate(authenticationDefinitionDelegate: AuthenticationDefintionDelegate) {
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
    
    @IBAction func onEditDidBegin(_ sender: Any) {
        passwordHint.show(customView: passwordHintTableView!, direction: .down, in: view, from: (tfPasscode.frame))
    }
    
    @IBAction func onEditingDidExit(_ sender: Any) {
        passwordHint.hide()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if PasswordValidator.hasPasswordMinimumLength(testStr: tfPasscode.text) != hintDataSource["enter_at_least_eight_characters".localized()] {
            hintDataSource.updateValue(PasswordValidator.hasPasswordMinimumLength(testStr: tfPasscode.text), forKey: "enter_at_least_eight_characters".localized())
            passwordHintTableView?.reloadData()
        }
        
        if PasswordValidator.hasPasswordCapitalLetter(testStr: tfPasscode.text)  != hintDataSource["enter_at_least_one_capital_letter".localized()]{
            hintDataSource.updateValue(PasswordValidator.hasPasswordCapitalLetter(testStr: tfPasscode.text), forKey: "enter_at_least_one_capital_letter".localized())
            passwordHintTableView?.reloadData()
        }
        
        if PasswordValidator.hasPasswordDigit(testStr: tfPasscode.text) != hintDataSource["enter_at_least_one_digit".localized()] {
            hintDataSource.updateValue(PasswordValidator.hasPasswordDigit(testStr: tfPasscode.text), forKey:"enter_at_least_one_digit".localized())
            passwordHintTableView?.reloadData()
        }
        
        if PasswordValidator.hasPasswordCustomCharacters(testStr: tfPasscode.text) != hintDataSource["enter_at_least_one_special_character".localized()] {
            hintDataSource.updateValue(PasswordValidator.hasPasswordCustomCharacters(testStr: tfPasscode.text), forKey:"enter_at_least_one_special_character".localized())
            passwordHintTableView?.reloadData()
        }
        
        passwordHintAdapter?.setDataSource(hintDataSource: hintDataSource)
        passwordIsValid = !hintDataSource.values.contains(false)
        
        if passwordIsValid == false {
            tfConfirmPasscode.isUserInteractionEnabled = false
            tfConfirmPasscode.text = nil
        }
        else {
            tfConfirmPasscode.isUserInteractionEnabled = true
            if textField == tfConfirmPasscode {
                guard (tfPasscode.text?.hasPrefix(textField.text!))! else {
                    UIHelper.showSpecificSnackBar(message: "no_match_snackbar".localized(), color: UIColorHelper.redColor)
                    return
                }
                if tfConfirmPasscode.text == tfPasscode.text {
                    let authentication = Authentication(credentials: tfPasscode.text, authenticationType: 0)
                    authenticationDefinitionDelegate?.authenticationSucceed(authentication: authentication)
                }
            }
        }
    }
}

