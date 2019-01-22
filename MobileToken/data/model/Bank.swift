
import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Bank: Object, Mappable, NSCopying{
    static let AYANDE = R.string.localizable.ayande()
    static let SADERAT = R.string.localizable.saderat()
    
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
    
    let cardList = List<Card>()
    
    
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
        return Bank(name: name, logoResourceId: logoResourceId, cardList: cardList)
    }
    
}
