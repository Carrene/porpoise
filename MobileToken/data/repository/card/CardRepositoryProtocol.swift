import Foundation

protocol CardRepositoryProtocol: Repository where Model == Card, Identifier == Int {
    func addCard(card: Card,bank:Bank, onDone: ((RepositoryResponse<Card>) -> ())?)
}
