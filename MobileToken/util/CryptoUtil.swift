import Foundation
import CryptoSwift

class CryptoUtil {
    static var keyDrivated = false
    static func keyDerivationBasedOnPBE(pin:[UInt8],salt:[UInt8])->[UInt8]?{
        var key: [UInt8]?
        do {
            key =  try PKCS5.PBKDF2(password: pin, salt: salt,iterations: 10000, variant: .sha256).calculate()
            CryptoUtil.keyDrivated = true
        } catch {
            print("\(error)")
        }
        return  key
    }
    
    
   
}
