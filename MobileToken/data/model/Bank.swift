

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Bank: Object, Mappable, NSCopying{
    
    @objc private dynamic var Name: String? = nil
    public var name: String? {
        get { return Name }
        set { Name = newValue }
    }
    
    private var logoResourceId: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(name: String, logoResourceId: String? = nil) {
        self.init()
        self.name = name
        self.logoResourceId = logoResourceId
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Bank(name: self.name!, logoResourceId: self.logoResourceId)
    }
    
}
