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
    
    static func generateRandomData(size: Int) throws -> Data {
        var data = Data(count: size)
        var d = data
        let result = d.withUnsafeMutableBytes {
            (mutableBytes: UnsafeMutablePointer<UInt8>) -> Int32 in
            SecRandomCopyBytes(kSecRandomDefault, data.count, mutableBytes)
        }
        
        if result != errSecSuccess {
            throw GenerateRandomDataError.UnableToGenerateRandomData
        }
        print(type(of: d))
        return d
    }
   
}

enum GenerateRandomDataError: Error {
    case UnableToGenerateRandomData
}
