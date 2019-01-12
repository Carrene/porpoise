import Foundation

class CardListPresenter : CardListPresenterProtocol {
    
    unowned let view: CardListViewProtocol
    
    required init(view: CardListViewProtocol) {
        self.view = view
    }
    
    func getBankList() {
        //view.setBankList(banks: <#T##[Bank]#>)
    }
    
}
