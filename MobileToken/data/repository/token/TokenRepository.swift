

import Foundation
class TokenRepository: TokenRepositoryProtocol {
    let tokenRealmRepository = TokenRealmRepository()
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Token>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Token]>) -> ())?) {
        tokenRealmRepository.getAll() { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
            
        }
    }
    
    func update(_ token: Token, onDone: ((RepositoryResponse<Token>) -> ())?) {
        tokenRealmRepository.update(token) { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
            
        }
    }
}
