

import Foundation
import RealmSwift
class CardRealmRepository: CardRepositoryProtocol {
    func get(identifier: Int, onDone: ((RepositoryResponse<Card>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
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
        var existCard = realm.objects(Card.self).filter("CardNumber = '\(card.number!)'").first
        if existCard == nil{
            existCard = card
        }
        else {
            existCard?.TokenList.append(objectsIn: card.TokenList)
        }
        
        do {
            try realm.write {
                realm.add(existCard?.copy() as! Card, update: true)
            }
            onDone?(RepositoryResponse(value: (existCard?.copy() as! Card), restDataResponse: nil, error: nil))
        }
        catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
}
