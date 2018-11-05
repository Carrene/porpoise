//
//  OtpViewDesignable.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/14/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

@IBDesignable

class OtpViewDesignable: UIView {
    
    @IBOutlet weak var vComponent: UIView!
    @IBOutlet weak var lbOtp: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var vProgress: UIProgressView!
    @IBOutlet weak var btCopy: UIButton!
    var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        initUIComponent()
 
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OtpViewDesignable", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func initUIComponent() {
        vProgress.progress = 0
        vProgress.progressViewStyle = .bar
        vComponent.layer.masksToBounds = true
        vComponent.layer.cornerRadius = 5
        btCopy.layer.masksToBounds = true
        btCopy.layer.cornerRadius = 5
    }
}

