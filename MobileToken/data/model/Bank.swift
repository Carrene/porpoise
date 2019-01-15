
import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Bank: Object, Mappable, NSCopying{
    
    override class func primaryKey() -> String {
        return "Name"
    }
    
    @objc private dynamic var Name: String? = nil
    var name: String? {
        get { return Name }
        set { Name = newValue }
    }
    
    @objc private dynamic var Secret:String? = nil
    var secret:String? {
        get { return Secret }
        set { Secret=newValue }
    }
    
    private var CardList = List<Card>()
    var cardList: List<Card>? {
        get { return CardList }
        set { CardList = newValue ?? List<Card>() }
    }
    
    private var LogoResourceId: String?
    var logoResourceId:String? {
        get { return LogoResourceId }
        set { LogoResourceId=newValue }
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(name: String? = nil, logoResourceId: String? = nil, cardList: List<Card>? = nil) {
        self.init()
        self.name = name
        self.logoResourceId = logoResourceId
        self.cardList = cardList
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Bank(name: name, logoResourceId: logoResourceId, cardList: cardList)
    }
    
}
