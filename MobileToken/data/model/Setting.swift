import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Setting: Object, Mappable, NSCopying{
    
    @objc dynamic var Id: Int = 1
    public var id: Int {
        get { return Id }
        set { Id = newValue }
    }
    
    override class func primaryKey() -> String {
        return "Id"
    }
    
    @objc dynamic var LockTimer: Int = 60
    public var lockTimer: Int {
        get { return LockTimer }
        set { LockTimer = newValue }
    }
    
    @objc dynamic var VisibleOtp = false
    public var visibleOtp: Bool {
        set {
            VisibleOtp = newValue
        }
        get {return VisibleOtp}
    }
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        
    }
    
    convenience init(lockTimer: Int, isOTPEnable: Bool) {
        self.init()
        self.lockTimer = lockTimer
        self.visibleOtp = isOTPEnable
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Setting(lockTimer: self.lockTimer, isOTPEnable: self.visibleOtp)
    }
    
}
