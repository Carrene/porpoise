//
//  AuthenticationViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, AuthenticationDelegate {
    
    @IBOutlet weak var vAuthenticationContainer: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
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
                if repoResponse.value?.authenticationType == 0 {
                    //TODO: test localize with R
                    self?.lbTitle.text = "lb_enter_password".localized()
                    self?.embedVCPassword(authentication:repoResponse.value!)
                } else {
                    self?.lbTitle.text = "lb_enter_pattern".localized()
                    self?.embedVCPattern(authentication: repoResponse.value!)
                }
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func embedVCPassword(authentication:Authentication) {
        var vcPassword: AuthenticationPasswordViewController?
        vcPassword = R.storyboard.main.authenticationPasswordViewController()
        vcPassword?.setDelegate(authenticationDelegate: self)
        vcPassword?.setAuthentication(authentication: authentication)
        vcPassword?.willMove(toParent: self)
        self.addChild(vcPassword!)
        vAuthenticationContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = vAuthenticationContainer.bounds
    }
    
    func embedVCPattern(authentication:Authentication) {
        var vcPattern: AuthenticationPatternViewController?
        vcPattern = R.storyboard.main.authenticationPatternViewController()
        vcPattern?.setDelegate(authenticationDelegate: self)
        vcPattern?.setAuthentication(authentication: authentication)
        vcPattern?.willMove(toParent: self)
        self.addChild(vcPattern!)
        vAuthenticationContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = vAuthenticationContainer.bounds
    }
    
    func authenticationSucceed() {        
    
    }
}

