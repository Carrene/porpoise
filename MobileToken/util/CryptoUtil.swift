import Foundation
import CryptoSwift

class CryptoUtil {
    static func keyDerivationBasedOnPBE(pin:[UInt8],salt:[UInt8])->[UInt8]?{
        var key: [UInt8]?
        do {
                key =  try PKCS5.PBKDF2(password: pin, salt: salt, variant: .sha256).calculate()
        } catch {
            print("\(error)")
        }
        print("key:++++" + (key?.toBase64())!)
        return  key
    }
    
   
}
