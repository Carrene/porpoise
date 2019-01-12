import Foundation

class CardListPresenter : CardListPresenterProtocol {
    
    unowned let view: CardListViewProtocol
    
    required init(view: CardListViewProtocol) {
        self.view = view
    }
    
    func getBankList() {
        let repository = UserRepository()
        let onDataResponse : ((RepositoryResponse<[Bank]>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
                if response.value == nil {
                    self!.view.noBank()
                }
                else {
                    self!.view.setBankList(banks: response.value!)
                }
            }
        }
    }
}
