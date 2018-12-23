import Foundation

class SettingRepository:SettingRepositoryProtocol {
    
    func get(onDone: ((RepositoryResponse<Setting>) -> ())?) {
        
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Setting>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Setting]>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func update(_: Setting, onDone: ((RepositoryResponse<Setting>) -> ())?) {
        
    }
    
    
}
