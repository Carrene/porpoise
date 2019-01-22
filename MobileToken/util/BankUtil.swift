import Foundation

import Foundation
import UIKit
class BankUtil {
    
    public static func getColor(bank: Bank) -> UIColor {
        switch bank.name {
        case Bank.AYANDE:
            return R.color.ayandehColor()!
        case Bank.SADERAT:
            return R.color.saderatColor()!
        default:
            return R.color.errorLight()!
        }
    }
    
    
    public static func getLogo(bank: Bank) -> UIImage? {
        
        switch bank.name {
        case Bank.AYANDE:
            return R.image.colorBankAyandehLogo()
        case Bank.SADERAT:
            return R.image.bankSaderatLogo()
        default:
            return nil
            
        }
    }
    
    public static func getLightLogo(bank: Bank) -> UIImage? {
        
        switch bank.name {
        case Bank.AYANDE:
            return R.image.lightBankAyandehLogo()
        case Bank.SADERAT:
            return R.image.lightBankSaderatLogo()
        default:
            return nil
            
        }
    }
    
    
    
    
}







