import Foundation

class CardListPresenter : CardListPresenterProtocol {
    
    unowned let view: CardListViewProtocol
    
    required init(view: CardListViewProtocol) {
        self.view = view
    }
    
    func getBankList() {
        let repository = BankRepository()
        let onDataResponse : ((RepositoryResponse<[Bank]>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
                if response.value?.count == 0 {
                    self!.view.noBank()
                }
                else if response.value != nil{
                    self!.view.setBankList(banks: response.value!)
                }
            }
        }
        repository.getAll(onDone: onDataResponse)
    }
    
    
}
