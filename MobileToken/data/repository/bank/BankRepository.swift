

import Foundation
class BankRepository: BankRepositoryProtocol {
    
    let bankRealmRepository = BanckRealmRepository()
    func get(identifier: Int, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Bank]>) -> ())?) {
        bankRealmRepository.getAll() { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
        onDone?(RepositoryResponse())
    }
    
    func update(_ bank: Bank, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        bankRealmRepository.update(bank) {realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
    }
}
