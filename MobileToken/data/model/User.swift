
import CryptoSwift
import Foundation
import RealmSwift
import ObjectMapper
import DeviceKit

class User: Object, Mappable, NSCopying {

    @objc private dynamic var PhoneNumber: String?
    public var phone: String? {
        get { return PhoneNumber }
        set { PhoneNumber = newValue }
    }
    override class func primaryKey() -> String {
        return "PhoneNumber"
    }
    
    @objc private dynamic var Secret: String?
    public var secret: String? {
        get { return Secret }
        set { Secret = newValue }
    }
    
    public var activationCode: String?
    
    public var  udid: String { return UIDevice.current.identifierForVendor!.uuidString.sha1() }
     public var deviceName: String { return Device().description }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func ignoredProperties() -> [String] {
        return ["secret"]
    }
    
    convenience init( phone: String? = nil, activationCode: String? = nil) {
        self.init()
        self.phone = phone
        self.activationCode = activationCode
    }
    
    func mapping(map: Map) {
        map.shouldIncludeNilValues = true
        self.phone <- map["phone"]
        self.secret <- map["secret"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return User(phone: phone)
    }
    
}
