
import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift
import CryptoSwift

enum AuthenticationTypeEnum: String {
    case PATTERN = "pattern"
    case PASSWORD = "password"
}

class Authentication: Object, Mappable, NSCopying{
    

    @objc dynamic var Id: Int = 1
    public var id: Int {
        get { return Id }
        set { Id = newValue }
    }
    override class func primaryKey() -> String {
        return "Id"
    }
    
    @objc dynamic var AuthenticationType: String? = nil
    public var authenticationType: AuthenticationTypeEnum? {
        get {
                return AuthenticationTypeEnum(rawValue: (AuthenticationType)!)
            
        }
        set { AuthenticationType = newValue?.rawValue }
    }
    
    @objc dynamic var AttemptsNumber = 0
    fileprivate var attemptsNumber: Int {
        get { return AttemptsNumber }
        set { AttemptsNumber = newValue }
    }
    
    @objc dynamic var Digest: String? = nil
    public var credential: String? {
        get { return Digest }
        set {
            Digest = newValue!
        }
    }
    
    @objc dynamic var Salt: String? = nil
    public var salt: String? {
        get { return Salt }
        set {
            Salt = newValue!
        }
    }
        
    @objc dynamic var MaxAttempts: Int = 5
    public var maxAttempts: Int { return MaxAttempts }
    
    private var authentication : Authentication?
    
    public var isLocked: Bool { return attemptsNumber >= maxAttempts }
    
    public var remainedAttempts: Int { return max(maxAttempts - attemptsNumber, 0) }
    
    public func failAttempt() {
        attemptsNumber = attemptsNumber + 1
    }
    
    public func successAttempt() {
        if !isLocked { attemptsNumber = 0 }
    }
    
    
    public func getRemainNumber() ->Int {
        return maxAttempts - attemptsNumber
    }
    
    public func unlock() {
        attemptsNumber = 0
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(credentials: String, authenticationType: AuthenticationTypeEnum, attemptsNumber: Int? = 0, salt: String? = nil) {
        self.init()
        self.credential = credentials
        self.authenticationType = authenticationType
        self.attemptsNumber = attemptsNumber!
        if salt == nil {
            self.salt = AES.randomIV(16).toHexString()
        }else {
            self.salt = salt
        }
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Authentication(credentials: self.credential!, authenticationType: self.authenticationType!, attemptsNumber: self.attemptsNumber, salt: self.salt)
    }
    
}
