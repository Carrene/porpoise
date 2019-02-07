import Foundation

protocol CardListViewProtocol: class {
    func setBankList(banks: [Bank])
    func noBank()
    func reloadCardPager()
    func updateCardList(card:Card)
    func addCard(card: Card)
    func deleteCard(card: Card)
}

protocol CardListPresenterProtocol {
    func getBankList()
    func addCard(card:Card,bank:Bank)
    func editCard(card: Card)
    func deleteCard(card: Card)
    func deleteToken(token: Token)
}

