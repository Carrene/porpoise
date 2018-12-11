

import Foundation
import RealmSwift

class AuthenticationRealmRepository: AuthenticationRepositoryProtocol {
    
    func get(onDone: ((RepositoryResponse<Authentication>) -> ())?) {
        get(identifier: 1) { repositoryResponse in
                onDone?(repositoryResponse)
                    onDone?(repositoryResponse)
        }
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

}
