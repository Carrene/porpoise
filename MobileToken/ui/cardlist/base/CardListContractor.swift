import Foundation

protocol CardListViewProtocol: class {
    func setBankList(banks: [Bank])
}

protocol CardListPresenterProtocol {
    func getBankList()
}

