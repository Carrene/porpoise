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

    @IBOutlet weak var bt: MyButton!
    @IBOutlet weak var bt1: MyButton1!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var width: NSLayoutConstraint!
    @IBOutlet weak var lbOtp: UILabel!
    @IBOutlet weak var animeView: UIView!
    var timer: Timer?
    var frame: CGRect?
    override func viewDidLoad() {
        super.viewDidLoad()
        bt1.setTitle("Salam", for: .normal)
        progressView.progress = 0
        progressView.trackTintColor = .white
        progressView.progressTintColor = .red
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        UILabel.appearance().font = UIFont(name: "IranSansRegular", size: UILabel.appearance().font.pointSize)
        
    }
    
    @objc func updateTimer() {
        progressView.progress += 1/60
        if progressView.progress >= 1 {
            progressView.progress = 0
            // generate new otp
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        frame = animeView.frame
        start(self)
        
        self.lbOtp.text = "12345   رمز یکبار مصرف"
        let font = UIFont(name: "IranSansRegular.ttf", size: 85)
        bt1.setTitle("رمز یکبار مصرف", for: .normal)
        bt.titleLabel?.text = "رمز یکبار مصرف"
        bt.titleLabel?.font = font
    }
    
    
    
    func start(_ sender: Any) {
        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 60, animations: { () -> Void in
            self.width.constant = self.lbOtp.layer.frame.width
            self.view.layoutIfNeeded()
        }, completion: { (value: Bool) in
            self.width.constant = 0
            self.start(self)
            self.lbOtp.text = "54321   رمز یکبار مصرف"
            self.animeView.layer.removeAllAnimations()
            
        })
    }
    @IBAction func resetProgress(_ sender: Any) {
        self.width.constant = 0
        self.progressView.progress = 0
        self.start(self)
    }

}

