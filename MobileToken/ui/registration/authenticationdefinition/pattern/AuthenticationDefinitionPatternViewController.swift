//
//  AuthenticationDefinitionPatternViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//


import UIKit
import Foundation
import HUIPatternLockView_Swift
class AuthenticationDefinitionPatternViewController: UIViewController {
    
    var authenticationDefinitionDelegate: AuthenticationDefintionDelegate?
    var firstAttemptPattern: String?
    var secondAttemptPattern: String?
    
    @IBOutlet weak var vPattern: HUIPatternLockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponent()
    }
    
    func initUIComponent() {
        
        self.vPattern.resetDotsState()
        self.vPattern.normalDotImage = #imageLiteral(resourceName: "patternGrayDot")
        self.vPattern.highlightedDotImage = #imageLiteral(resourceName: "patternDot")
        self.vPattern.dotWidth = 25
        configuareLockViewWithImages()
    }
    
    func setDelegate(authenticationDefinitionDelegate: AuthenticationDefintionDelegate) {
        
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
    
    private func configuareLockViewWithImages() {
        
        vPattern.didDrawPatternPassword = { (lockView: HUIPatternLockView, count: Int, password: String?) -> Void in
            guard count > 0 else {
                return
            }
            
            self.vPattern.resetDotsState()
            
            if self.firstAttemptPattern == nil {
                
                if count > 3 {
                    
                    self.firstAttemptPattern = password
                    UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_try_for_second_time(), color: R.color.secondary()!)
                }else {
                    
                    UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_pattern_min_point_error(), color: R.color.errorColor()!)
                }
            } else {
                
                self.secondAttemptPattern = password
                let authentication = Authentication(credentials: password, authenticationType: 1)
                if self.secondAttemptPattern == self.firstAttemptPattern {
                    self.authenticationDefinitionDelegate?.authenticationSucceed(authentication: authentication)
                    UIHelper.showSpecificSnackBar(message:R.string.localizable.sb_successfully_done() , color: R.color.eyeCatching()!)
                } else {
                    
                    self.firstAttemptPattern = nil
                    self.secondAttemptPattern = nil
                    UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_not_match(), color: R.color.errorColor()!)
                }
            }
        }
    }
}

