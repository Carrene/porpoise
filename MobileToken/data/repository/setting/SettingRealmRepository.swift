import Foundation
import RealmSwift

class SettingRealmRepository:SettingRepositoryProtocol {
    
    func get(onDone: ((RepositoryResponse<Setting>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        if let setting = realm.object(ofType: Setting.self, forPrimaryKey: Identifier.self)?.copy() as? Setting {
            onDone?(RepositoryResponse(value: setting))
            
        } else {
            onDone?(RepositoryResponse(value: nil, restDataResponse: nil, error: nil))
        }
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Setting>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Setting]>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func update(_ setting : Setting, onDone: ((RepositoryResponse<Setting>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        do {
            try realm.write {
                realm.add(setting.copy() as! Setting, update: true)
            }
            onDone?(RepositoryResponse(value: setting.copy() as? Setting))
        } catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
    
    
}
