//
//  AuthenticationDefinitionPatternViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/10/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import Foundation
import HUIPatternLockView_Swift

class SettingAuthenticationDefinitionPatternViewController: UIViewController {

    var firstAttemptPattern: String?
    var secondAttemptPattern: String?
    @IBOutlet weak var viewPattern: HUIPatternLockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
    }
    
    func initUIComponent() {
        self.viewPattern.resetDotsState()
        self.viewPattern.normalDotImage = #imageLiteral(resourceName: "patternGrayDot")
        self.viewPattern.highlightedDotImage = #imageLiteral(resourceName: "patternDot")
        self.viewPattern.dotWidth = 25
        configuareLockViewWithImages()
    }
    

    private func configuareLockViewWithImages() {
        
        viewPattern.didDrawPatternPassword = { (lockView: HUIPatternLockView, count: Int, password: String?) -> Void in
            guard count > 0 else {
                return
            }
            
            self.viewPattern.resetDotsState()
            
            if self.firstAttemptPattern == nil {
                
                if count > 3 {
                    
                    self.firstAttemptPattern = password
                    UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_try_for_second_time(), color: R.color.secondary()!)
                }else {
                    
                    UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_pattern_min_point_error(), color: R.color.errorColor()!)
                }
            } else {
                
                self.secondAttemptPattern = password!
                let authentication = Authentication(credentials: password, authenticationType: 1)
                if self.secondAttemptPattern == self.firstAttemptPattern {
                    //self.authenticationDefinitionDelegate?.authenticationSucceed(authentication: authentication)
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

