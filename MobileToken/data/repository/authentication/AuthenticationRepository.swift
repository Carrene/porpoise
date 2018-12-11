//
//  AuthenticationRestRealmRestRepository.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/21/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
class AuthenticationRepository: AuthenticationRepositoryProtocol {
    
    private let realmRepo = AuthenticationRealmRepository()
    
    func get(onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        realmRepo.get() { repositoryResponse in
            if repositoryResponse.value != nil {
                onDone?(repositoryResponse)
            } else {
                self.realmRepo.update(Authentication()) { repositoryResponse in
                    onDone?(repositoryResponse)
                }
            }
        }
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        realmRepo.get(identifier: identifier) { repositoryResponse in
            onDone?(repositoryResponse)
        }
    }
    
    func getAll(onDone: ((RepositoryResponse<[Authentication]>) -> ())?) {
        realmRepo.getAll() { repositoryResponse in
            onDone?(repositoryResponse)
        }
    }
    
    func update(_ authentication: Authentication, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        realmRepo.update(authentication) { repositoryResponse in
            onDone?(repositoryResponse)
        }
    }
    
}
