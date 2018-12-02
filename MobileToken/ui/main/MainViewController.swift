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
        navigateToTabbar()
        
//        let vc : UIViewController = (R.storyboard.tabbar.instantiateInitialViewController()!)
//        print(vc)
//        present(vc, animated: false, completion: nil)
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

}
