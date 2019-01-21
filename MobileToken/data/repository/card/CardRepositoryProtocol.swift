import Foundation

protocol CardRepositoryProtocol: Repository where Model == Card, Identifier == String {
    func addCard(card: Card,bank:Bank, onDone: ((RepositoryResponse<Card>) -> ())?)
    func delete(identifier: Identifier, onDone: ((RepositoryResponse<Card>) -> ())?)
}
