//
//  UserRepository.swift
//  alpha
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 Nuesoft. All rights reserved.
//

import Foundation

class UserRepository: UserRepositoryProtocol {
    
    let userRestRepository = UserRestRepository()
    let userRealmRepository = UserRealmRepository()
    
    func bind(user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        userRestRepository.bind(user: user) { restRepositoryResponse in
            onDone?(restRepositoryResponse)
            if restRepositoryResponse.restDataResponse?.response?.statusCode == 200 {
                self.userRealmRepository.update(restRepositoryResponse.value!) { realmRepositoryResponse in
                    if let error = restRepositoryResponse.error {
                        onDone?(RepositoryResponse(error: error))
                        return
                    }
                    onDone?(restRepositoryResponse)
                }
            }
        }
    }
    
    func claim(user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        userRestRepository.claim(user: user) { userRestRepository in
            onDone?(userRestRepository)
        }
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<User>) -> ())?) {
        userRealmRepository.get(identifier: identifier) { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
            
        }
    }
    
    func getAll(onDone: ((RepositoryResponse<[User]>) -> ())?) {
        userRealmRepository.getAll() { realmRepositoryResponse in
            
            onDone?(realmRepositoryResponse)
        }
    }
    
    func update(_: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        
    }

}