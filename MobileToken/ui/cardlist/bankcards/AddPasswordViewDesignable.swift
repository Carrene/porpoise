//
//  AddPasswordViewDesignable.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/14/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

@IBDesignable

class AddPasswordViewDesignable: UIView {
    
    @IBOutlet weak var labelAddOtp: UILabel!
    @IBOutlet weak var vBackground: UIView!
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
        contentView.frame = bounds
        
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
       
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView! {
        let nib = UINib(resource: R.nib.addPasswordViewDesignable)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        initUIComponent()
        return view
    }
    
    func initUIComponent() {
        vBackground.layer.masksToBounds = true
        vBackground.layer.cornerRadius = 5
    }
}


