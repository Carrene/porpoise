//
//  AuthenticationPasswordViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import PasswordTextField
protocol AuthenticationDelegate:class {
    func authenticationSucceed()
}
class AuthenticationPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textFieldPassword: UITextField!
    
    var authenticationDelegate: AuthenticationDelegate?
    private var authentication: Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponent()
    }
    
    func setDelegate(authenticationDelegate:AuthenticationDelegate) {
        
        self.authenticationDelegate = authenticationDelegate
    }
    
    func initUIComponent() {
        
        textFieldPassword.delegate = self
        textFieldPassword.becomeFirstResponder()
    }
    
    func setAuthentication(authentication:Authentication) {
        
        self.authentication = authentication
    }
    
    @IBAction func textFieldPasswordEditingChanged(_ sender: UITextField) {
        
        if textFieldPassword.text == authentication?.credentials {
            
            authenticationDelegate?.authenticationSucceed()
            textFieldPassword.enablesReturnKeyAutomatically = true
        }else {
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textFieldPassword.text == authentication?.credentials {
            
            authenticationDelegate?.authenticationSucceed()
        }else {
            
            self.dismissKeyboard()
            textFieldPassword.text = ""
            UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_wrong_password(), color: R.color.errorColor()!)
        }
        
        self.dismissKeyboard()
        return true
    }
    
    
}
