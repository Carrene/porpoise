//
//  SettingAuthenticationDefinitionViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/10/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class SettingAuthenticationDefinitionViewController: UIViewController {

    @IBOutlet weak var authenticationTypeContainer: UIView!
    @IBOutlet weak var scAuthenticationType: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
       
    }
    
    func initUIComponent() {
        self.hideKeyboardWhenTappedAround()
        let attr = NSDictionary(object: R.font.iranSansMobileBold(size: 16)!, forKey: NSAttributedString.Key.font as NSCopying)
        scAuthenticationType.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any] , for: .normal)
        embedVCPattern()
        //getAuthentication()
    }
    
   
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        authenticationTypeContainer.subviews.forEach({ $0.removeFromSuperview() })
        if sender.selectedSegmentIndex == 1 {
            embedVCPassword()
        } else {
            embedVCPattern()
        }
    }
    
    func embedVCPassword() {
        var vcPassword: SettingAuthenticationDefinitionPasswordViewController?
        vcPassword = R.storyboard.settingAuthenticationDefinition.settingAuthenticationDefinitionPasswordViewController()
        //vcPassword?.setDelegate(authenticationDefinitionDelegate: self)
        vcPassword?.willMove(toParent: self)
        self.addChild(vcPassword!)
        authenticationTypeContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = authenticationTypeContainer.bounds
    }
    
    func embedVCPattern() {
        var vcPattern: SettingAuthenticationDefinitionPatternViewController?
        vcPattern = R.storyboard.settingAuthenticationDefinition.settingAuthenticationDefinitionPatternViewController()
        //vcPattern?.setDelegate(authenticationDefinitionDelegate: self)
        vcPattern?.willMove(toParent: self)
        self.addChild(vcPattern!)
        authenticationTypeContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = authenticationTypeContainer.bounds
    }
    

}



