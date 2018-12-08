//
//  MainViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/5/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //startApplicationOnboard()
        navigateToImportToken()
        //navigateToTabbar()
        
//        let vc : UIViewController = (R.storyboard.tabbar.instantiateInitialViewController()!)
//        print(vc)
//        present(vc, animated: false, completion: nil)
    }
    
    fileprivate func startApplicationOnboard() {
        let onIntroEnd = { [weak self] in
            
            UIApplication.shared.statusBarStyle = .default
            
        }
        let introVC = IntroViewController.newInstance(withIntroEndAction: onIntroEnd)
        present(introVC, animated: true, completion: nil)
    }
    
    func navigateToAuthentication() {
        performSegue(withIdentifier: R.segue.mainViewController.navigateToAuthentication.identifier, sender: self)
    }

    func navigatoToAuthenticationDefinition() {
        performSegue(withIdentifier: R.segue.mainViewController.navigatoToAuthenticationDefinition.identifier, sender: self)
    }

    func navigateToTabbar() {
        performSegue(withIdentifier: R.segue.mainViewController.navigateToTabbar.identifier, sender: self)
    }
    
    func navigateToImportToken() {
        performSegue(withIdentifier: R.segue.mainViewController.navigatoToImportToken.identifier, sender: self)
    }

}
