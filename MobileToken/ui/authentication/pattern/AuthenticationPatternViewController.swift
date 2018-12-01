//
//  AuthenticationPatternViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import HUIPatternLockView_Swift
class AuthenticationPatternViewController: UIViewController {
    @IBOutlet weak var vPattern: HUIPatternLockView!
    
    var authenticationDelegate: AuthenticationDelegate?
    var authentication: Authentication?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initUIComponent()
    }
    
    func setDelegate(authenticationDelegate:AuthenticationDelegate) {
        
        self.authenticationDelegate = authenticationDelegate
    }
    
    func setAuthentication(authentication: Authentication) {
        
        self.authentication = authentication
    }
    
    func initUIComponent() {
        
        vPattern.resetDotsState()
        vPattern.normalDotImage = R.image.patternDot()
        vPattern.highlightedDotImage = R.image.patternGrayDot()
        vPattern.dotWidth = 25
        configuareLockViewWithImages()
    }
    
    private func configuareLockViewWithImages() {
        
        vPattern.didDrawPatternPassword = { (lockView: HUIPatternLockView, count: Int, password: String?) -> Void in
            guard count > 0 else {
                return
            }
            
            self.vPattern.resetDotsState()
            
            if self.authentication?.credentials == password {
                
                self.authenticationDelegate?.authenticationSucceed()
            }else {
                
                UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_wrong_pattern(), color: R.color.errorColor()!)
            }
        }
    }
}
