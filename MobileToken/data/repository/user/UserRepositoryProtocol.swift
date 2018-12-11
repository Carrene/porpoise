
import Foundation

protocol UserRepositoryProtocol: Repository where Model == User, Identifier == Int{
    func bind(user: User, onDone: ((RepositoryResponse<User>) -> ())?)
    func claim(user: User, onDone: ((RepositoryResponse<User>) -> ())?)
}
