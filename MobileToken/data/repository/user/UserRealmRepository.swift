import Foundation
import RealmSwift

class UserRealmRepository:UserRepositoryProtocol {
    
    func get(bank: Bank, onDone: ((RepositoryResponse<User>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration())
        if let user = realm.objects(User.self).filter("Bank.Name='"+bank.name!+"'").first {
            
        }
        //print(user)
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<User>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
//        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration())
//        if let user = realm.object(ofType: User.self, forPrimaryKey: identifier)?.copy() as? User {
//            onDone?(RepositoryResponse(value: user))
//        } else {
//            onDone?(RepositoryResponse(value: nil, restDataResponse: nil, error: nil))
//        }
        
    }
    
    func update(_ user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration())
        do {
            try realm.write {
                realm.add(user.copy() as! User, update: true)
            }
            onDone?(RepositoryResponse(value: user.copy() as? User))
        } catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
    
    func bind(user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func claim(user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[User]>) -> ())?) {
        
    }
    
}
