//
//  MyButton.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/13/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class MyButton: UIButton {
    
    // Connect the custom button to the custom class
    @IBOutlet weak var view: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(nibName: "MyButton")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(nibName: "MyButton")
    }
    
    func setup(nibName:String) {
        view = (loadViewFromNib(nibName: nibName) as! UIButton)
        view.frame = bounds
        
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                 UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
        
        // Add our border here and every custom setup
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.titleLabel!.font = UIFont.systemFont(ofSize: 20)
    }
    
    func loadViewFromNib(nibName:String) -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIButton
        let font = UIFont(name: "IranSansRegular.ttf", size: 85)
        view.titleLabel?.font = font
        setTitle("dssddsdsds", for: .normal)
        return view
    }

}
