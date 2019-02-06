import Foundation
import TTGSnackbar

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
    
    func addCard(card:Card,bank:Bank) {
        let repository = CardRepository()
        let onDataResponse : ((RepositoryResponse<Card>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
                self?.getBankList()
                
            }
        }
        repository.addCard(card: card, bank: bank, onDone: onDataResponse)
    }
    
    func editCard(card: Card) {
        let repository = CardRepository()
        let onDataResponse : ((RepositoryResponse<Card>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
               self?.getBankList()
            }
        }
        repository.update(card, onDone: onDataResponse)
    }
    
    func deleteCard(identifier: String) {
        let repository = CardRepository()
        let onDataResponse : ((RepositoryResponse<Card>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
                self?.getBankList()
            }
        }
        repository.delete(identifier: identifier, onDone: onDataResponse)
    }
    
    func deleteToken(token: Token) {
        let repository = TokenRepository()
        let onDataResponse : ((RepositoryResponse<Token>) -> ()) =  { [weak self] response in
            if response.error != nil {
                
                SnackBarHelper.init(message: R.string.localizable.sb_token_deleted_unsuccessfully(), color: R.color.errorDark()!, duration: .short).show()
            } else {
                self?.getBankList()
                SnackBarHelper.init(message: R.string.localizable.sb_token_deleted_successfully(), color: R.color.secondaryDark()!, duration: .short).show()
            }
        }
        repository.delete(identifire: token.id!, onDone: onDataResponse)
    }
    
    
    
}
