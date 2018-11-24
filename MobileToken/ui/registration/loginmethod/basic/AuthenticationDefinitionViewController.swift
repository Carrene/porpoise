//
//  AuthenticationDefinitionViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//


import UIKit

class AuthenticationDefinitionViewController: UIViewController, AuthenticationDefintionDelegate {
    
    @IBOutlet weak var authenticationTypeContainer: UIView!
    @IBOutlet weak var scAuthenticationType: UISegmentedControl!
    
    var authentication: Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        authenticationTypeContainer.subviews.forEach({ $0.removeFromSuperview() })
        if sender.selectedSegmentIndex == 1 {
            embedVCPassword()
        } else {
            embedVCPattern()
        }
    }
    
    func initUIComponent() {
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.hidesBackButton = true
        let attr = NSDictionary(object: R.font.iranSansMobileBold(size: 16)!, forKey: NSAttributedString.Key.font as NSCopying)
        scAuthenticationType.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any] , for: .normal)
        embedVCPattern()
        //getAuthentication()
    }
    
    
    
    func embedVCPassword() {
        var vcPassword: AuthenticationDefinitionPasswordViewController?
        vcPassword = R.storyboard.main.authenticationDefinitionPasswordViewControllerIdentifier()
        vcPassword?.setDelegate(authenticationDefinitionDelegate: self)
        vcPassword?.willMove(toParent: self)
        self.addChild(vcPassword!)
        authenticationTypeContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = authenticationTypeContainer.bounds
    }
    
    func embedVCPattern() {
        var vcPattern: AuthenticationDefinitionPatternViewController?
        vcPattern = R.storyboard.main.authenticationDefinitionPatternViewControllerIdentifier()
        vcPattern?.setDelegate(authenticationDefinitionDelegate: self)
        vcPattern?.willMove(toParent: self)
        self.addChild(vcPattern!)
        authenticationTypeContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = authenticationTypeContainer.bounds
    }
    
    func authenticationSucceed(authentication:Authentication) {
        if self.authentication?.id != nil {
            updateAuthentication(authentication: authentication)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = R.string.localizable.backBarItem()
        navigationItem.backBarButtonItem = backItem
    }
    
    func getAuthentication() {
        let authenticationRestRepository = AuthenticationRepository()
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
        let authenticationRestRepository = AuthenticationRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                authenticationRestRepository.get(onDone: nil)
            }
        }
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
    
}

