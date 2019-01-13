import Foundation

class CardRepository: CardRepositoryProtocol {
    
    let cardRealmRepository = CardRealmRepository()
    
    func addCard(card: Card, bankName: String, onDone: ((RepositoryResponse<Card>) -> ())?) {
        
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Card>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
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
}
