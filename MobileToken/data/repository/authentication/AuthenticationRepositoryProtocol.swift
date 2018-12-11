

import Foundation

protocol AuthenticationRepositoryProtocol: Repository where Model == Authentication, Identifier == Int {
    
    func get(onDone: ((RepositoryResponse<Model>) -> ())?)
}
