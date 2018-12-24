import Foundation

class SettingRepository : SettingRepositoryProtocol {
    
    let settingRealmRepository = SettingRealmRepository()
    
    func get(onDone: ((RepositoryResponse<Setting>) -> ())?) {
        settingRealmRepository.get {
            realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Setting>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Setting]>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func update(_ setting: Setting, onDone: ((RepositoryResponse<Setting>) -> ())?) {
        settingRealmRepository.update(setting) { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
    }
    
    
}
