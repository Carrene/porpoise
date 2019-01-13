import Foundation

protocol CardListViewProtocol: class {
    func setBankList(banks: [Bank])
    func noBank()
}

protocol CardListPresenterProtocol {
    func getBankList()
    func addCard(card:Card,bankName:String)
}

