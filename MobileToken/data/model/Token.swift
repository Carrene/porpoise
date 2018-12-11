import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

//TODO(Fateme) Just extend from realm not object mapper
class Token: Object, Mappable, NSCopying{
    
    @objc fileprivate dynamic var TokenPaket: String? = nil
    var tokenPaket: String? {
        get { return TokenPaket }
        set { TokenPaket = newValue }
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
        self.tokenPaket = tokenPaket
        self.secret = secret
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Token(tokenPaket: tokenPaket, secret: secret)
    }
}
