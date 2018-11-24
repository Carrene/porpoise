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
    
    @IBOutlet weak var tfPassword: PasswordTextField!
    
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
        
        tfPassword.delegate = self
        tfPassword.becomeFirstResponder()
    }
    
    func setAuthentication(authentication:Authentication) {
        
        self.authentication = authentication
    }
    
    @IBAction func tfPasswordEditingChanged(_ sender: UITextField) {
        
        if tfPassword.text == authentication?.credentials {
            
            authenticationDelegate?.authenticationSucceed()
            tfPassword.enablesReturnKeyAutomatically = true
        }else {
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if tfPassword.text == authentication?.credentials {
            
            authenticationDelegate?.authenticationSucceed()
        }else {
            
            self.dismissKeyboard()
            tfPassword.text = ""
            //UIHelper.showSpecificSnackBar(message: "sb_wrong_password".localized(), color: UIColorHelper.redColor)
        }
        
        self.dismissKeyboard()
        return true
    }
    
    
}
