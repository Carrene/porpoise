//
//  ActionSheet.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/11/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import UIKit
import XLActionController

open class ActionSheet: ActionCell {
    
    @IBOutlet var viewCell: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize() {
        backgroundColor = .white
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.15)
        selectedBackgroundView = backgroundView
        separatorView?.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0)
    }
}
