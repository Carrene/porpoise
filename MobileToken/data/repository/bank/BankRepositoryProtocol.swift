import Foundation
protocol BankRepositoryProtocol: Repository where Model == Bank, Identifier == Int {
    
    func get(card: Card, onDone: ((RepositoryResponse<Bank>) -> ())?)
}
