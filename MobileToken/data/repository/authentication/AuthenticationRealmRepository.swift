//
//  AuthenticationRealmRepository.swift
//  alpha
//
//  Created by Arash Foumani on 6/27/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation
import RealmSwift

class AuthenticationRealmRepository: AuthenticationRepositoryProtocol {
    
    func get(onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        get(identifier: 1) { repositoryResponse in
            if repositoryResponse.value != nil {
                onDone?(repositoryResponse)
            } else {
                self.create(Authentication()) { repositoryResponse in
                    onDone?(repositoryResponse)
                }
            }
        }
    }
    
    func create(_ authentication: Authentication, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration)
        guard realm.object(ofType: Authentication.self, forPrimaryKey: authentication.id) == nil else {
            onDone?(RepositoryResponse(error: EntityExistException()))
            return
        }
        do {
            try realm.write {
                realm.add(authentication.copy() as! Authentication, update: false)
            }
            onDone?(RepositoryResponse(value: authentication.copy() as? Authentication))
        } catch { onDone?(RepositoryResponse(error: error)) }
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration)
        let authentication = realm.object(ofType: Authentication.self, forPrimaryKey: identifier)?.copy() as? Authentication
        onDone?(RepositoryResponse(value: authentication))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Authentication]>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration)
        let authentications: [Authentication] = realm.objects(Authentication.self).map { $0.copy() as! Authentication }
        onDone?(RepositoryResponse(value: authentications))
    }
    
    func update(_ authentication: Authentication, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration)
        do {
            
            try realm.write {
                realm.add(authentication.copy() as! Authentication, update: true)
            }
            onDone?(RepositoryResponse(value: authentication.copy() as? Authentication))
        } catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
    
    func update(_ authentications: [Authentication], onDone: ((RepositoryResponse<[Authentication]>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func delete(_ authentication: Authentication, onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func delete(_ authentications: [Authentication], onDone: ((RepositoryResponse<[Authentication]>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
}
