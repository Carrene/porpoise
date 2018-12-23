import Foundation

protocol SettingRepositoryProtocol: Repository where Model == Setting, Identifier == Int {
    
    func get(onDone: ((RepositoryResponse<Model>) -> ())?)
    
}
