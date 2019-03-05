import Foundation

import Foundation
import UIKit
class BankUtil {
    
    public static func getColor(bank: Bank) -> UIColor {
        
        switch bank.id {
        case 2:
            return R.color.ayandehColor()!
        case 3:
            return R.color.saderatColor()!
        default:
            return R.color.errorLight()!
        }
    }
    
    public static func getName(bank: Bank) -> String {
        
        switch bank.id {
        case 2:
            return R.string.localizable.ayande()
        case 3:
            return R.string.localizable.saderat()
        default:
            return ""
        }
    }
    
    
    public static func getLogo(bank: Bank) -> UIImage? {
        
        switch bank.id {
        case 2:
            return R.image.bankAyandehLogo()
        case 3:
            return R.image.bankSaderatLogo()
        default:
            return nil
            
        }
    }
    
    public static func getLightLogo(bank: Bank) -> UIImage? {
        
        switch bank.id {
        case 2:
            return R.image.bankAyandehLogo()
        case 3:
            return R.image.bankSaderatLogo()
        default:
            return nil
            
        }
    }
    
}







