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
    static let STORYBOARD_ID = "Authentication_Pattern_VC".localized()
    var authentication: Authentication?
    @IBOutlet weak var vPattern: HUIPatternLockView!
    var authenticationDelegate: AuthenticationDelegate?
    
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
        vPattern.lineColor = .black
        vPattern.normalDotImage = #imageLiteral(resourceName: "patternGrayDot")
        vPattern.highlightedDotImage = #imageLiteral(resourceName: "patternDot")
        vPattern.dotWidth = 40
        
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
                UIHelper.showSpecificSnackBar(message: "Wrong Pattern", color: UIColorHelper.redColor)
            }
        }
    }
}
