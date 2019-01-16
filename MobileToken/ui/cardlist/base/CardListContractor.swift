import Foundation

protocol CardListViewProtocol: class {
    func setBankList(banks: [Bank])
    func noBank()
    func reloadCardPager()
}

protocol CardListPresenterProtocol {
    func getBankList()
    func addCard(card:Card,bank:Bank)
}

