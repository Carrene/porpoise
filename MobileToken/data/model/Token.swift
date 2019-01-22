import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift
import oath
import CryptoSwift

//TODO(Fateme) Just extend from realm not object mapper
class Token: Object, Mappable, NSCopying{
    
    public enum CryptoModuleId: Int {
        
        case one = 1
        case two = 2
    }
    
    @objc dynamic var Id: String?
    public var id: String? {
        get { return Id }
        set { Id = newValue }
    }
    
    @objc private dynamic var TokenPacket: String? = nil
    public var tokenPacket: String? {
        get { return TokenPacket }
        set { TokenPacket = newValue }
    }
    
    private var expireDate: String?
    private var cryptoModuleId: CryptoModuleId?
    private var seed: [UInt8]?
    private var name: String?
    private var hashType: HashType?
    private var version: Int?
    private var timeInterval: Int?
    private var otpLength: Int?
    private var bankId: Int?
    private var bank: Bank?
    
    required convenience init(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String {
        return "Id"
    }
    override static func ignoredProperties() -> [String] {
        return ["secret"]
    }
    
    convenience init(tokenPaket: String? = nil, id: String? = nil, bank: Bank? = nil, cryptoModuleId: CryptoModuleId? = nil) {
        self.init()
        self.tokenPacket = tokenPaket
        self.bank = bank
        self.cryptoModuleId = cryptoModuleId
        if id == nil {
            self.id = NSUUID().uuidString.lowercased()
        } else {
            self.id = id!
        }
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Token(tokenPaket: tokenPacket, id: self.id)
    }
    
    func parse() -> Bool {
        
        let tokenPlusIvPacketBytes = tokenPacket?.hexaToBytes()
        let iv = Array(tokenPlusIvPacketBytes![0..<16])
        let secretBytes = Data(base64urlEncoded: bank!.secret!)?.bytes
        let tokenPacketEncrypted = Array(tokenPlusIvPacketBytes![16..<tokenPlusIvPacketBytes!.count])
        
        let tokenPacketDecrypted = try! AES(key: secretBytes!, blockMode: CBC(iv: iv), padding: .pkcs5).decrypt(tokenPacketEncrypted)
        
        let checksum = Array(tokenPacketDecrypted[tokenPacketDecrypted.count - 4 ..< tokenPacketDecrypted.count])
        let tokenPacketDecryptedWithoutChecksum = Array(tokenPacketDecrypted[0 ..< tokenPacketDecrypted.count - 4])
        let checkSumString = String(bytes: checksum, encoding: .utf8)
        let isValid = isChecksumValid(secret: secretBytes!, tokenpacket: tokenPacketDecryptedWithoutChecksum, checksum: checkSumString!)
        
        if isValid {
            self.version = Int(tokenPacketDecrypted[0])
            if self.version == 1 {
                let array : [UInt8] = Array(tokenPacketDecryptedWithoutChecksum[1 ..< 5])
                var value : UInt32 = 0
                let data = NSData(bytes: array, length: 4)
                data.getBytes(&value, length: 4)
                value = UInt32(bigEndian: value)
                //TODO: check expiredate date
                self.expireDate = "" + "\(value)"
                bank?.id
                let cryptoModuleId = Int(tokenPacketDecryptedWithoutChecksum[5])
                if let cryptoModule = self.cryptoModuleId, cryptoModule != CryptoModuleId(rawValue: cryptoModuleId){
                    return false
                }
                self.otpLength = Int(tokenPacketDecryptedWithoutChecksum[6])
                self.timeInterval = Int(tokenPacketDecryptedWithoutChecksum[7])
                self.bankId = Int(tokenPacketDecryptedWithoutChecksum[8])
                if self.bankId != bank!.id {
                    return false
                }
                self.seed = Array(tokenPacketDecryptedWithoutChecksum[9 ..< 29])
                self.name = String(bytes: Array(tokenPacketDecryptedWithoutChecksum[29 ..< tokenPacketDecryptedWithoutChecksum.count]), encoding: .utf8)
                self.hashType = HashType.SHA1
            }
            return true
        }
        return false
    }
    
    func isChecksumValid(secret: [UInt8], tokenpacket: [UInt8], checksum: String) -> Bool {
        let length = 4
        var hmac = [UInt8]()
        do {
            hmac = try calculteHMAC(hashType: HMAC.Variant.sha1, secret: secret, data: tokenpacket)!
            
        } catch {
            return false
        }
        let offset = hmac[hmac.count - 1] & 0xf
        var otpBinary = Int((hmac[Int(offset)] & 0x7f)) << 24
        otpBinary = otpBinary | Int((hmac[Int(offset+1)] & 0xff)) << 16
        otpBinary = otpBinary | Int((hmac[Int(offset+2)] & 0xff)) << 8
        otpBinary = otpBinary | Int((hmac[Int(offset+3)] & 0xff))
        let DIGITS_POWER = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000]
        let otp = Int(otpBinary) % DIGITS_POWER [length]
        var result = String(otp)
        
        while (result.count < length){
            result = "0"+result
        }
        return checksum == result
    }
    
    func calculteHMAC(hashType:HMAC.Variant , secret:Array<UInt8>, data:Array<UInt8>) throws -> Array<UInt8>?{
        
        let hmac = try HMAC(key: secret, variant: hashType).authenticate(data)
        return hmac
    }
    
    func generateTotp() -> String {
        let otp = Totp(secret: seed!, timeInterval: timeInterval!, otpLength: otpLength!, hashType: hashType!)
        return otp.generateTotp() ?? "Error"
    }
}
