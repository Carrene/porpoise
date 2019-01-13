import Foundation

protocol CardRepositoryProtocol: Repository where Model == Card, Identifier == Int {
    func addCard(card: Card,bankName:String, onDone: ((RepositoryResponse<Card>) -> ())?)
}
