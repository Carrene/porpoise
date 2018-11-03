//
//  ViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/9/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
class ViewController: UIViewController {

    @IBOutlet var width: NSLayoutConstraint!
    @IBOutlet weak var lbOtp: UILabel!
    @IBOutlet weak var animeView: UIView!
    var frame: CGRect?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        frame = animeView.frame
        start(self)
        
        self.lbOtp.text = "12345   رمز یکبار مصرف"
    }
    
    
    
    func start(_ sender: Any) {
        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 5, animations: { () -> Void in
            self.width.constant = self.lbOtp.layer.frame.width
            self.view.layoutIfNeeded()
        }, completion: { (value: Bool) in
            self.width.constant = 0
            self.start(self)
            self.lbOtp.text = "54321   رمز یکبار مصرف"
            self.animeView.layer.removeAllAnimations()
            
        })
    }
}

