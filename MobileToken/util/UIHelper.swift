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
    
    
    static func iranSansBold(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileBold.fontName, size: size)!
    }
    
    static func iranSansLight(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileLight.fontName, size: size)!
    }
    
    static func iranSansMedium(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileMedium.fontName, size: size)!
    }
    
    static func iranSansUltraLight(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileUltraLight.fontName, size: size)!
    }
    
    static func iranSansMobile(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobile.fontName, size: size)!
    }
    
    static func iranSansMobileFaNum(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileFaNum.fontName, size: size)!
    }
    
    static func iranSansMobileFaNumBold(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileFaNumBold.fontName, size: size)!
    }
    
    static func iranSansMobileFaNumLight(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileFaNumLight.fontName, size: size)!
    }
    
    static func iranSansMobileFaNumMedium(size: CGFloat) -> UIFont {
        return UIFont(name: R.font.iranSansMobileFaNumMedium.fontName, size: size)!
    }
    
    static func showFailedSnackBar() {
        SnackBarHelper.init(message: R.string.localizable.sb_bad_request(),color:R.color.errorColor()!, duration:TTGSnackbarDuration.long).show()
    }
    
    static func showSuccessfulSnackBar(message:String) {
        SnackBarHelper.init(message: message,color:R.color.eyeCatching()!, duration:TTGSnackbarDuration.long).show()
    }
    
    static func showSpecificSnackBar(message:String, color:UIColor) {
        SnackBarHelper.init(message: message,color:color, duration: TTGSnackbarDuration.long).show()
    }
    static func showSpecificSnackBar(message:String, color:UIColor, duration: TTGSnackbarDuration) {
        SnackBarHelper.init(message: message,color:color, duration: duration).show()
    }
}
