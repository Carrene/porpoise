//
//  MyButton1.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/13/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class MyButton1: MyButton {
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setup1()
    }
    
     func setup1() {
        // Add our border here and every custom setup
        super.view.layer.borderWidth = 5
        super.view.layer.cornerRadius = 5
        super.view.layer.borderColor = UIColor.green.cgColor
        super.view.layer.backgroundColor = UIColor.gray.cgColor
        super.view.titleLabel!.font = UIFont.systemFont(ofSize: 20)
       
    }
    
   
}

