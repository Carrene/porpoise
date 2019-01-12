import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

//TODO(Fateme) Just extend from realm not object mapper
class Token: Object, Mappable, NSCopying{
    
    @objc private dynamic var TokenPacket: String? = nil
    public var tokenPacket: String? {
        get { return TokenPacket }
        set { TokenPacket = newValue }
    }
    
    private var expireDate: String?
    private var cryptoModuleId: Int?
    private var seed: [UInt8]?
    private var name: String?
//    private var hashType: HashType?
    private var version: Int?
    private var timeInterval: Int?
    private var otpLength: Int?
    private var secret: String?
    
    required convenience init(map: Map) {
        self.init()
    }
    
    override static func ignoredProperties() -> [String] {
        return ["secret"]
    }
    
    convenience init(tokenPaket: String? = nil, secret: String? = nil) {
        self.init()
        self.tokenPacket = tokenPaket
        self.secret = secret
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Token(tokenPaket: tokenPacket, secret: secret)
    }
}
