

import Foundation
import RealmSwift
class TokenRealmRepository: TokenRepositoryProtocol {
   
    func get(identifier: String, onDone: ((RepositoryResponse<Token>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Token]>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        let realmTokenResults: [Token]? = realm.objects(Token.self).map{$0.copy() as! Token}
        if realmTokenResults == nil {
            onDone?(RepositoryResponse(value: nil))
        } else {
            onDone?(RepositoryResponse(value: realmTokenResults))
        }
    }
    
    func update(_ token: Token, onDone: ((RepositoryResponse<Token>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        do {
            try realm.write {
                realm.add(token.copy() as! Token, update:  true)
            }
            onDone?(RepositoryResponse(value: token, restDataResponse: nil, error: nil))
        }
        catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
    
    func delete(tokens: [Token], onDone: ((RepositoryResponse<[Token]>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        var responseTokens = [Token]()
        do {
            try realm.write {
                for token in tokens {
                    let token = realm.objects(Token.self).filter("Id='"+token.id!+"'").first
                    let tokenCopy = token?.copy() as! Token
                    responseTokens.append(tokenCopy)
                    realm.delete(token!)
                }
               
            }
            onDone?(RepositoryResponse(value: responseTokens))

        } catch {
            onDone?(RepositoryResponse(error: error))
        }
        
    }
    
    
}
