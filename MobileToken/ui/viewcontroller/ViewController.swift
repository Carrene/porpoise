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

    @IBOutlet weak var vOtpParent: UIView!
    @IBOutlet weak var vOtp: OtpViewDesignable!
    @IBOutlet weak var bt: MyButton!
    @IBOutlet weak var bt1: MyButton1!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var width: NSLayoutConstraint!
    @IBOutlet weak var lbOtp: UILabel!
    @IBOutlet weak var animeView: UIView!
    var timer: Timer?
    var frame: CGRect?
    var otpView: OtpViewDesignable?
    override func viewDidLoad() {
        super.viewDidLoad()
        bt1.setTitle("Salam", for: .normal)
        progressView.progress = 0
        progressView.trackTintColor = .white
        progressView.progressTintColor = .red
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        vOtp.vProgress.progressViewStyle = .bar
       ass()
//        UILabel.appearance().font = UIFont(name: "IranSansRegular", size: UILabel.appearance().font.pointSize)
        
        
        
    }
    
    
    
    @objc func updateTimer() {
        vOtp.vProgress.progress += 1/60
        progressView.progress += 1/60
        if progressView.progress >= 1 {
            progressView.progress = 0
            vOtp.vProgress.progress = 0
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

    func ass() {
        let od = OtpViewDesignable()
        var cv = od.loadViewFromNib()
        vOtpParent.addSubview(cv!)
        
        let pv = AddPasswordViewDesignable()
        cv = pv.loadViewFromNib()
        vOtpParent.addSubview(cv!)
    }
}

