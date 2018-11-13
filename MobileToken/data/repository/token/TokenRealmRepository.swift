    //
//  TokenRealmRepository.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/22/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
    import RealmSwift
    class TokenRealmRepository: TokenRepositoryProtocol {
        func get(identifier: Int, onDone: ((RepositoryResponse<Token>) -> ())?) {
            onDone?(RepositoryResponse(error: UnsupportedOperationException()))
        }
        
        func getAll(onDone: ((RepositoryResponse<[Token]>) -> ())?) {
            let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration)
            let realmTokenResults: [Token]? = realm.objects(Token.self).map{$0.copy() as! Token}
            if realmTokenResults == nil {
                onDone?(RepositoryResponse(value: nil))
            } else {
                onDone?(RepositoryResponse(value: realmTokenResults))
            }
        }
        
        func update(_ token: Token, onDone: ((RepositoryResponse<Token>) -> ())?) {
            let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration)
            do {
                try realm.write {
                    realm.add(token.copy() as! Token, update:  true)
                }
                onDone?(RepositoryResponse(value: token, restDataResponse: nil, error: nil))
            }
            catch {
                onDone?(RepositoryResponse(error: error))
            }
        }
        
        
    }
