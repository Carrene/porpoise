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
        SnackBarHelper.init(message: R.string.localizable.sb_bad_request(),color:R.color.errorDark()!, duration:TTGSnackbarDuration.middle).show()
    }
    
    static func showSuccessfulSnackBar(message:String) {
        SnackBarHelper.init(message: message,color:R.color.secondaryDark()!, duration:TTGSnackbarDuration.middle).show()
    }
    
    static func showSpecificSnackBar(message:String, color:UIColor) {
        SnackBarHelper.init(message: message,color:color, duration: TTGSnackbarDuration.middle).show()
    }
    
    static func showSpecificSnackBar(message:String, color:UIColor, duration: TTGSnackbarDuration) {
        SnackBarHelper.init(message: message,color:color, duration: duration).show()
    }
    
    static func getMaskCardNumber(number: String) -> [String] {
        //        var maskCardNumber = [String]()
        var maskCardNumber = [String]()
        let template = number
        
        let index1 = template.index(template.startIndex, offsetBy: 3)
        var substring = template[...index1]
        maskCardNumber.append(String(substring))
        let index2 = template.index(template.startIndex, offsetBy: 4)
        let index3 = template.index(template.startIndex, offsetBy: 5)
        substring = template[index2...index3]
        maskCardNumber.append(String(substring)+"**")
        maskCardNumber.append("****")
        let index4 = template.index(template.endIndex, offsetBy: -4)
        substring = template[index4...]
        maskCardNumber.append(String(substring))
        return maskCardNumber
    }
}
