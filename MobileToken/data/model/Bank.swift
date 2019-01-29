
import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Bank: Object, Mappable, NSCopying{
    
    
    public enum BankName: String {
        case MELI = "ملی"
        case AYANDE = "آینده"
        case SADERAT = "صادرات"
    }
    
    override class func primaryKey() -> String {
        return "Name"
    }
    
    @objc private dynamic var Name: String? = nil
    var name: String? {
        get { return Name }
        set {
            Name = newValue
            switch name! {
            case BankName.MELI.rawValue:
                self.id = 1
            case BankName.AYANDE.rawValue:
                self.id = 2
            case BankName.SADERAT.rawValue:
                self.id = 3
            default: break
            }
            
            
        }
    }
    
    @objc private var Id: Int = 0
    var id: Int {
        get { return Id}
        set { Id = newValue}
    }
    
    @objc private dynamic var Secret:String? = nil
    var secret:String? {
        get { return Secret }
        set { Secret=newValue }
    }
    
    let cardList = List<Card>()
    
    
    private var LogoResourceId: String?
    var logoResourceId:String? {
        get { return LogoResourceId }
        set { LogoResourceId=newValue }
    }
    
    override static func ignoredProperties() -> [String] {
        return [  "LogoResourceId"]
    }
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(name: BankName? = nil, id: Int? = nil, logoResourceId: String? = nil, cardList: List<Card>? = nil, secret: String? = nil) {
        self.init()
        self.id = id ?? 0
        self.name = name?.rawValue
        self.logoResourceId = logoResourceId
        self.secret = secret
        self.cardList.removeAll()
        if let cards = cardList {
            for card in cards {
                let c = card.copy() as! Card
                self.cardList.append(c)
            }
        }
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Bank(name: BankName(rawValue: name!),id: self.id, logoResourceId: logoResourceId, cardList: cardList, secret: self.secret)
    }
    
}
