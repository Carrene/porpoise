//
//  SnckbarHelper.swift
//  alpha
//
//  Created by hamed akhlaghi on 4/25/1397 AP.
//  Copyright © 1397 Nuesoft. All rights reserved.
//

import TTGSnackbar
import Foundation

class SnackBarHelper:TTGSnackbar {
    
    override init(message: String, duration: TTGSnackbarDuration) {
        super.init(message: message, duration: duration)
    }
    
    init(message: String,color:UIColor, duration: TTGSnackbarDuration) {
        super.init(message: message, duration: duration)
        self.messageTextFont = UIFont.systemFont(ofSize: 15)
        self.messageTextAlign = .left
        self.backgroundColor=color
        self.messageTextColor=UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
