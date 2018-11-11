//
//  AuthenticationRepository.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation

class AuthenticationRepository : AuthenticationRepositoryProtocol {
    
    
    let authenticationRealmRepository = AuthenticationRealmRepository();
    
    
    func get(onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        
    }
    
    func create(_: Authentication, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        
    }
    
    func getAll(onDone: ((RepositoryResponse<[Authentication]>) -> ())?) {
        
    }
    
    func update(_: Authentication, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        
    }
    
    func update(_: [Authentication], onDone: ((RepositoryResponse<[Authentication]>) -> ())?) {
        
    }
    
    func delete(_: Authentication, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        
    }
    
    func delete(_: [Authentication], onDone: ((RepositoryResponse<[Authentication]>) -> ())?) {
        
    }
    
    
    
}
