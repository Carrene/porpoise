import Foundation
import RealmSwift

class UserRealmRepository:UserRepositoryProtocol {
    
    func get(bank: Bank, onDone: ((RepositoryResponse<User>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        if let user = realm.objects(User.self).filter("Bank.Name='"+bank.name!+"'").first {
            onDone?(RepositoryResponse(value:user))
        }
        else {
            onDone?(RepositoryResponse(value:nil))
        }
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<User>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func update(_ user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
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
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        let userList : [User] = realm.objects(User.self).map { $0.copy() as! User }
        onDone?(RepositoryResponse(value: userList))
    }
    
}
