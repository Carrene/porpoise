import CryptoSwift
import Foundation
import RealmSwift
import ObjectMapper
import DeviceKit

class User: Object, Mappable, NSCopying {

    override class func primaryKey() -> String {
        return "PhoneNumber"
    }
    
    @objc private dynamic var PhoneNumber: String?
    var phone: String? {
        get { return PhoneNumber }
        set { PhoneNumber = newValue }
    }
    
    @objc private dynamic var Secret: String?
    var secret: String? {
        get { return Secret }
        set { Secret = newValue }
    }
    
    @objc private dynamic var Bank : Bank?
    var bank : Bank?{
        get{return Bank}
        set{Bank = newValue}
    }
    
    var activationCode: String?
    var udid: String { return UIDevice.current.identifierForVendor!.uuidString.sha1() }
    var deviceName: String { return Device().description }
    
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
