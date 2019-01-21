import Foundation

class CardRepository: CardRepositoryProtocol {
    
    let cardRealmRepository = CardRealmRepository()
    
    func addCard(card: Card, bank: Bank, onDone: ((RepositoryResponse<Card>) -> ())?) {
        cardRealmRepository.addCard(card: card, bank: bank) {
            realmRepositoryResponse in onDone?(realmRepositoryResponse)
        }
    }
    
    func get(identifier: String, onDone: ((RepositoryResponse<Card>) -> ())?) {
        cardRealmRepository.get(identifier: identifier) { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
    }
    
    func getAll(onDone: ((RepositoryResponse<[Card]>) -> ())?) {
        cardRealmRepository.getAll() { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
    }
    
    func update(_ card: Card, onDone: ((RepositoryResponse<Card>) -> ())?) {
        cardRealmRepository.update(card) { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
            
        }
    }
    
    func delete(identifier:String, onDone: ((RepositoryResponse<Card>) -> ())?) {
        cardRealmRepository.delete(identifier: identifier) {
            realmRepoResponse in onDone?(realmRepoResponse)
        }
    }
}
