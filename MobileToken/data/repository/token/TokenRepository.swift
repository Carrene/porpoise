

import Foundation
class TokenRepository: TokenRepositoryProtocol {
    
    let tokenRealmRepository = TokenRealmRepository()
    
    func get(identifier: String, onDone: ((RepositoryResponse<Token>) -> ())?) {
        tokenRealmRepository.get(identifier: identifier, onDone: onDone)
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
    
    func delete(tokens: [Token], onDone: ((RepositoryResponse<[Token]>) -> ())?) {
        tokenRealmRepository.delete(tokens: tokens) { realmRepositoryRsponse in
            onDone?(realmRepositoryRsponse)
        }
    }
}
