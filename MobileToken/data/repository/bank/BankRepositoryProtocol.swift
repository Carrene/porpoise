import Foundation
protocol BankRepositoryProtocol: Repository where Model == Bank, Identifier == Int {
    
    func delete(bank: Bank, onDone: ((RepositoryResponse<Bank>) -> ())?)
}
