//
//  UIHelper.swift
//  alpha
//
//  Created by Fateme' Kazemi on 4/19/1397 AP.
//  Copyright © 1397 Nuesoft. All rights reserved.
//

import UIKit
import TTGSnackbar
class UIHelper {
    
    static var robotoFont = UIFont(name: "Roboto-Regular", size:16 )!
    static var robotoTitleFont = UIFont(name: "Roboto-Regular", size:28 )!
    static var robotoDetailFont = UIFont(name: "Roboto-Regular", size:14 )!
    static var robotoPlaceholderFont = UIFont(name: "Roboto-Regular", size:20 )!
    static func setTabbarItemFont(tabBarItem:UITabBarItem) {
        
    }
    
    static func showFailedSnackBar() {
        SnackBarHelper.init(message: "sb_bad_request".localized(),color:UIColorHelper.redColor, duration:TTGSnackbarDuration.long).show()
    }
    
    static func showSuccessfulSnackBar(message:String) {
        SnackBarHelper.init(message: message,color:UIColorHelper.greenColor, duration:TTGSnackbarDuration.long).show()
    }
    
    static func showSpecificSnackBar(message:String, color:UIColor) {
        SnackBarHelper.init(message: message,color:color, duration: TTGSnackbarDuration.long).show()
    }
    static func showSpecificSnackBar(message:String, color:UIColor, duration: TTGSnackbarDuration) {
        SnackBarHelper.init(message: message,color:color, duration: duration).show()
    }
}
