//
//  TokenRepository.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/22/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
class TokenRepository: TokenRepositoryProtocol {
   
    let tokenRealmRepository = TokenRealmRepository()
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Token>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Token]>) -> ())?) {
        tokenRealmRepository.getAll() { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
            
        }
    }
    
    func update(_ token: Token, onDone: ((RepositoryResponse<Token>) -> ())?) {
        tokenRealmRepository.update(token) { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
            
        }
    }
    
    
}
