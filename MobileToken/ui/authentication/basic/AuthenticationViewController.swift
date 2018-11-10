//
//  AuthenticationViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, AuthenticationDelegate {
    static let  STORYBOARD_ID = "Authentication_VC".localized()
    static let TO_TAB_BAR = "AuthentiationToTabBar"
    static let TO_REGISTRATION = "AuthenticationToRootViewController";
    var vcPassword: AuthenticationPasswordViewController?
    var vcPattern: AuthenticationPatternViewController?
    @IBOutlet weak var vAuthenticationContainer: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    var authentication: Authentication?
    override func viewDidLoad() {
        super.viewDidLoad()
        getAuthentication()
    }
    
    func getAuthentication() {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                self?.authentication = repoResponse.value
                if self?.authentication?.authenticationType == 0 {
                    self?.lbTitle.text = "lb_enter_password".localized()
                    self?.embedVCPassword()
                } else {
                    self?.lbTitle.text = "lb_enter_pattern".localized()
                    self?.embedVCPattern()
                }
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func embedVCPassword() {
        vcPassword = R.storyboard.main.authenticationPasswordViewController()
        vcPassword?.setDelegate(authenticationDelegate: self)
        vcPassword?.setAuthentication(authentication: authentication!)
        vcPassword?.willMove(toParent: self)
        self.addChild(self.vcPassword!)
        vAuthenticationContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = vAuthenticationContainer.bounds
    }
    
    func embedVCPattern() {
        vcPattern = R.storyboard.main.authenticationPatternViewController()
        vcPattern?.setDelegate(authenticationDelegate: self)
        vcPattern?.setAuthentication(authentication: authentication!)
        vcPattern?.willMove(toParent: self)
        self.addChild(self.vcPattern!)
        vAuthenticationContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = vAuthenticationContainer.bounds
    }
    
    func authenticationSucceed() {        
    
    }
}

