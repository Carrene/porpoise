
import Foundation
class ImportTokenPresenter: ImportTokenPresenterProtokol{
    
    unowned let view: ImportTokenViewProtocol

    required init(view: ImportTokenViewProtocol) {
        self.view = view
    }
    
    func importToken(tokenPacket: String, card: Card, cryptoModuleId: Token.CryptoModuleId) {
        let token = Token(tokenPaket: tokenPacket, bank: card.bank, cryptoModuleId: cryptoModuleId)
        let isSuccessful = token.parse()
        if isSuccessful {
            card.TokenList.append(token)
            card.TokenList.count
            updateCard(card: card)
        }
    }
    
    func updateCard(card: Card) {
        let repository = CardRepository()
        let onDataResponse : ((RepositoryResponse<Card>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
                if response.value == nil {
                    
                }
                else {
                    SnackBarHelper.init(message: "added", color: R.color.primary()!, duration: .long).show()
                }
            }
        }
        repository.update(card, onDone: onDataResponse)
    }
}
