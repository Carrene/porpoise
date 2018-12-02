//
//  CardCellXibView.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/13/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
@IBDesignable

class CardCellXibView: UIView {
    
    var contentView : UIView!
    @IBOutlet var imageLogo: UIImageView!
    @IBOutlet var labelBankName: UILabel!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var stackViewCardNumber: UIStackView!
    @IBOutlet var labelTitle2: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        initUIComponent()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
    func initUIComponent() {
        imageLogo.layer.cornerRadius = 10
    }
    
    func loadViewFromNib() -> UIView! {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "CardCell", bundle: bundle)
        let view = R.nib.cardCell.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
