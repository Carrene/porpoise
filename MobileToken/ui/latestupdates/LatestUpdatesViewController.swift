//
//  LatestUpdatesViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class LatestUpdatesViewController: UIViewController {

    @IBOutlet var buttonEnterProgram: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
        // Do any additional setup after loading the view.
    }
    
    func initUIComponent() {
        buttonEnterProgram.layer.cornerRadius = 10
    }

}
