import Foundation
import RealmSwift

class CardRealmRepository: CardRepositoryProtocol {
    
    func addCard(card: Card, bank: Bank, onDone: ((RepositoryResponse<Card>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        if let bank = realm.objects(Bank.self).filter("Id == \(bank.id)").first?.copy() as? Bank {
            do {
                
                try realm.write {
                    bank.CardList.append(card)
                    realm.add(bank.copy() as! Bank, update: true)

                }
                let card: Card? = realm.object(ofType: Card.self, forPrimaryKey: card.id)
                let cardCopy = card?.copy() as! Card
                cardCopy.bank = (card?.owners.first!.copy() as! Bank)
                onDone!(RepositoryResponse(value: cardCopy))

//                onDone?(RepositoryResponse(value: (card.copy() as! Card)))
            }
            catch {
                onDone?(RepositoryResponse(error: error))
            }
        }
        else {
            
        }
    }
    
    func get(identifier: String, onDone: ((RepositoryResponse<Card>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        let card: Card? = realm.object(ofType: Card.self, forPrimaryKey: identifier)
        let cardCopy = card?.copy() as! Card
        cardCopy.bank = (card?.owners.first!.copy() as! Bank)
        onDone!(RepositoryResponse(value: cardCopy))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Card]>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        let realmCardResult: [Card]? = realm.objects(Card.self).map{$0.copy() as! Card}
        if realmCardResult == nil {
            onDone?(RepositoryResponse(value: nil))
        } else {
            onDone?(RepositoryResponse(value: realmCardResult))
        }
    }
    
    func update(_ card: Card, onDone: ((RepositoryResponse<Card>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        do {
            try realm.write {

                realm.add(card.copy() as! Card, update: true)
            }
            let card: Card? = realm.object(ofType: Card.self, forPrimaryKey: card.id)
            let cardCopy = card?.copy() as! Card
            cardCopy.bank = (card?.owners.first!.copy() as! Bank)
            onDone!(RepositoryResponse(value: cardCopy))
           
        }
        catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
    
    func delete(identifier:String, onDone: ((RepositoryResponse<Card>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        let existCard = realm.objects(Card.self).filter("Id='"+identifier+"'").first
        do {
            try realm.write {
                for token in existCard!.TokenList {
                    realm.delete(token)
                }
                realm.delete(existCard!)
            }
            onDone?(RepositoryResponse(value: (existCard)))
        }
        catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
}
