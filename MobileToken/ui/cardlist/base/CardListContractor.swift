import Foundation

protocol CardListViewProtocol: class {
    func setBankList(banks: [Bank])
    func noBank()
    func reloadCardPager()
    func updateCardList(card:Card)
    func addCard(card: Card)
    func deleteCard(card: Card)
    func deleteToken(tokens: [Token])
    func bankRemoved(bank: Bank)
    func deletionError(message: String)
}

protocol CardListPresenterProtocol {
    func getBankList()
    func addCard(card:Card,bank:Bank)
    func editCard(card: Card)
    func deleteCard(card: Card)
    func deleteToken(tokens: [Token])
    func deleteBank(bank: Bank)
}

