//
//  AuthenticationDefinitionViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//


import UIKit

class AuthenticationDefinitionViewController: UIViewController, AuthenticationDefintionDelegate {
    
    static let  STORYBOARD_ID = "AuthenticationDefinitionViewController"
    
    @IBOutlet weak var authenticationTypeContainer: UIView!
    @IBOutlet weak var scAuthenticationType: UISegmentedControl!
    
    var vcPassword: AuthenticationDefinitionPasswordViewController?
    var vcPattern: AuthenticationDefinitionPatternViewController?
    var authentication: Authentication?
    
    public static let TO_Dashboard_SEGUE = "AuthenticationDefinitionToDashboard"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            vcPattern?.removeFromParent()
            vcPattern?.view.removeFromSuperview()
            embedVCPassword()
        } else {
            vcPassword?.removeFromParent()
            vcPassword?.view.removeFromSuperview()
            embedVCPattern()
        }
    }
    
    func initUIComponent() {
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.hidesBackButton = true
        embedVCPattern()
        getAuthentication()
    }
    
    
    
    func embedVCPassword() {
//        let storyboard = UIStoryboard(name: R.storyboard.main.name, bundle: nil)
        vcPassword = R.storyboard.main.authenticationDefinitionPasswordViewControllerIdentifier()
        vcPassword?.setDelegate(authenticationDefinitionDelegate: self)
        vcPassword?.willMove(toParent: self)
        self.addChild(self.vcPassword!)
        authenticationTypeContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = authenticationTypeContainer.bounds
    }
    
    func embedVCPattern() {
        vcPattern = R.storyboard.main.authenticationDefinitionPatternViewControllerIdentifier()
        vcPattern?.setDelegate(authenticationDefinitionDelegate: self)
        vcPattern?.willMove(toParent: self)
        self.addChild(self.vcPattern!)
        authenticationTypeContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = authenticationTypeContainer.bounds
    }
    
    func authenticationSucceed(authentication:Authentication) {
        if self.authentication?.id != nil {
            self.authentication?.credentials = authentication.credentials
            self.authentication?.authenticationType = authentication.authenticationType
            updateAuthentication(authentication: self.authentication!)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "navigation_bar_back".localized()
        navigationItem.backBarButtonItem = backItem
    }
    
    func getAuthentication() {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                self?.authentication = repoResponse.value
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func updateAuthentication(authentication: Authentication) {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                authenticationRestRepository.get(onDone: nil)
                self?.performSegue(withIdentifier: AuthenticationDefinitionViewController.TO_Dashboard_SEGUE, sender: self)
            }
        }
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
    
}

