//
//  CardRelmRepsitory.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/22/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import RealmSwift
class CardRealmRepository: CardRepositoryProtocol {
    func get(identifier: Int, onDone: ((RepositoryResponse<Card>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Card]>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration)
        let realmCardResult: [Card]? = realm.objects(Card.self).map{$0.copy() as! Card}
        if realmCardResult == nil {
            onDone?(RepositoryResponse(value: nil))
        } else {
            onDone?(RepositoryResponse(value: realmCardResult))
        }
    }
    
    func update(_ card: Card, onDone: ((RepositoryResponse<Card>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration)
        do {
            try realm.write {
                realm.add(card.copy() as! Card, update: true)
            }
            onDone?(RepositoryResponse(value: card, restDataResponse: nil, error: nil))
        }
        catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
}
