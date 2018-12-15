import UIKit
import TTGSnackbar

class UIHelper {
    
    static func iranSansBold(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileBold(size:size)!
    }
    
    static func iranSansLight(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileLight(size:size)!
    }
    
    static func iranSansMedium(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileMedium(size:size)!
    }
    
    static func iranSansUltraLight(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileUltraLight(size:size)!
    }
    
    static func iranSansMobile(size: CGFloat) -> UIFont {
        return R.font.iranSansMobile(size:size)!
    }
    
    static func iranSansMobileFaNum(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileFaNum(size:size)!
    }
    
    static func iranSansMobileFaNumBold(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileFaNumBold(size:size)!
    }
    
    static func iranSansMobileFaNumLight(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileFaNumLight(size: size)!
    }
    
    static func iranSansMobileFaNumMedium(size: CGFloat) -> UIFont {
        return R.font.iranSansMobileFaNumMedium(size: size)!
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
