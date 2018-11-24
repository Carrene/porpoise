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
    
    
    static func iranSanseBold(size: CGFloat) -> UIFont {
        return UIFont(name: "IRANSansMobile-Bold", size: size)!
    }
    
    static func iranSanseLight(size: CGFloat) -> UIFont {
        return UIFont(name: "IRANSansMobile-Light", size: size)!
    }
    
    static func iranSanseMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "IRANSansMobile-Medium", size: size)!
    }
    
    static func iranSanseUltraLight(size: CGFloat) -> UIFont {
        return UIFont(name: "IRANSansMobile-UltraLight", size: size)!
    }
    
    static func iranSanseMobile(size: CGFloat) -> UIFont {
        return UIFont(name: "IRANSansMobile", size: size)!
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
