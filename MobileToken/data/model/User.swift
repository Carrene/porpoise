import Foundation
import RealmSwift
import ObjectMapper
import DeviceKit
import CryptoSwift


class User: Object, Mappable, NSCopying {

    @objc private dynamic var PhoneNumber: String?
    var phone: String? {
        get { return PhoneNumber }
        set { PhoneNumber = newValue }
    }
    
    @objc private dynamic var UserBank : Bank?
    var bank : Bank? {
        get{return UserBank}
        set{UserBank = newValue}
    }
    
    @objc dynamic var Id: Int = 1
    public var id: Int {
        get { return Id }
        set { Id = newValue }
    }
    
    @objc dynamic var PrimaryKey: String = NSUUID().uuidString.lowercased()
    public var primaryKey: String {
        get { return PrimaryKey }
        set { PrimaryKey = newValue }
    }
    
    override class func primaryKey() -> String {
        return "PrimaryKey"
    }
    
    var activationCode: String?
    var udid: String { return UIDevice.current.identifierForVendor!.uuidString.sha1() }
    var deviceName: String { return Device().description }
    
   
    override static func ignoredProperties() -> [String] {
        return ["activationCode"]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init( phone: String? = nil, activationCode: String? = nil, bank: Bank? = nil) {
        self.init()
        self.phone = phone
        self.activationCode = activationCode
        self.bank = bank
    }
    
    func mapping(map: Map) {
        map.shouldIncludeNilValues = true
        self.phone <- map["phone"]
        let secret = map["secret"]
        if bank != nil {
            bank!.secret <- secret
        }else {
            self.bank = Bank()
            bank!.secret <- secret
        }
    }
    
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        return User(phone: phone, activationCode: nil, bank: bank)
    }
    
}
