
import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Bank: Object, Mappable, NSCopying{
    
    override class func primaryKey() -> String {
        return "Id"
    }
    
    @objc private dynamic var Id: Int = 0
    var id: Int {
        get { return Id}
        set { Id = newValue}
    }
    
    var phone: String?
    
    @objc private dynamic var Secret:String? = nil
    var secret:String? {
        get { return Secret }
        set { Secret=newValue }
    }
    
    let cardList = List<Card>()
    
    override static func ignoredProperties() -> [String] {
        return [ "phone"]
    }
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(id: Int? = nil, phone: String? = nil, cardList: List<Card>? = nil, secret: String? = nil) {
        self.init()
        self.id = id ?? 0
        self.secret = secret
        self.cardList.removeAll()
        if let cards = cardList {
            for card in cards {
                let bankCard = card.copy() as! Card
                self.cardList.append(bankCard)
            }
        }
    }
    
    func mapping(map: Map) {
        self.phone <- map["phone"]
        self.id <- map["bankId"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Bank(id: self.id, cardList: cardList, secret: self.secret)
    }
    
}
