//
//  CardRepository.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/22/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
class CardRepository: CardRepositoryProtocol {
    
    let cardRealmRepository = CardRealmRepository()
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Card>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Card]>) -> ())?) {
        cardRealmRepository.getAll() { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
    }
    
    func update(_ card: Card, onDone: ((RepositoryResponse<Card>) -> ())?) {
        cardRealmRepository.update(card) { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
            
        }
    }
    
    
}
