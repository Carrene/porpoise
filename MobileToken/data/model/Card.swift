import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Card: Object, Mappable, NSCopying{
    var a: List<User>?
    var b: [User]?
    
    @objc dynamic var Id: String = NSUUID().uuidString.lowercased()
    public var id: String {
        get { return Id }
        set { Id = newValue }
    }
    
    override class func primaryKey() -> String {
        return "Id"
    }
    
    @objc private dynamic var CardNumber: String? = nil
    public var number: String? {
        get { return CardNumber }
        set { CardNumber = newValue }
    }
    
    @objc private dynamic var Bank: Bank? = nil
    public var bank: Bank? {
        get { return Bank }
        set { Bank = newValue }
    }
    
    @objc private dynamic var CardName: String? = nil
    public var cardName: String? {
        get { return CardName }
        set { CardName = newValue }
    }
    
    @objc private dynamic var CardType: String? = nil
    public var type: CardTypeEnum? {
        get { return CardTypeEnum(rawValue: CardType!) }
        set { CardType = newValue?.rawValue }
    }
    
    public enum CardTypeEnum: String {
        case BANK = "BANK"
        case INTERNET = "INTERNET"
        case ADD = "ADD"
    }
   
    var TokenList = List<Token>()

    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(number: String? = nil, bank: Bank? = nil, cardName: String? = nil, cardType: CardTypeEnum? = nil) {
        self.init()
        self.number = number
        self.bank = bank
        self.cardName = cardName
        self.type = cardType
        
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Card(number: self.number, bank: self.bank, cardName: self.cardName, cardType: self.type)
    }
    
    public func getMaskCardNumber() -> [String] {
//        var maskCardNumber = [String]()
        var maskCardNumber = [String]()
        let template = number!
        
        let index1 = template.index(template.startIndex, offsetBy: 3)
        var substring = template[...index1]
        maskCardNumber.append(String(substring))
        let index2 = template.index(template.startIndex, offsetBy: 4)
        let index3 = template.index(template.startIndex, offsetBy: 5)
        substring = template[index2...index3]
        maskCardNumber.append(String(substring)+"**")
        maskCardNumber.append("****")
        let index4 = template.index(template.endIndex, offsetBy: -4)
        substring = template[index4...]
        maskCardNumber.append(String(substring))
        return maskCardNumber
    }
}

