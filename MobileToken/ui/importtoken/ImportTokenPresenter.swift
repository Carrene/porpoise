
import Foundation
import TTGSnackbar
class ImportTokenPresenter: ImportTokenPresenterProtokol{
    
    unowned let view: ImportTokenViewProtocol

    required init(view: ImportTokenViewProtocol) {
        self.view = view
    }
    
    func importToken(tokenPacket: String, card: Card, cryptoModuleId: Token.CryptoModuleId) {
        let token = Token(tokenPaket: tokenPacket, bank: card.bank, cryptoModuleId: cryptoModuleId)
//        let isSuccessful = token.parse()
       
        do {
            try token.validate()
            card.TokenList.append(token)
//            card.TokenList.count
            updateCard(card: card)
            
        } catch ParseTokenException.InvalidChecksumException{
            SnackBarHelper.init(message: R.string.localizable.sb_tokenimport_invalidchecksum(), color: R.color.errorDark()!, duration: .middle).show()
        } catch ParseTokenException.InvalidBankIdException {
            SnackBarHelper.init(message: R.string.localizable.sb_tokenimport_invalidbankid(), color: R.color.errorDark()!, duration: .middle).show()
        } catch ParseTokenException.InvalidCryptoModuleIdException {
            SnackBarHelper.init(message: R.string.localizable.sb_tokenimport_invalidcryptomoduleid(), color: R.color.errorDark()!, duration: .middle).show()
        } catch ParseTokenException.NumberFormatException {
            SnackBarHelper.init(message: R.string.localizable.sb_get_token_fail(), color: R.color.errorDark()!, duration: .middle).show()
        } catch ParseTokenException.InvalidKeyException {
            SnackBarHelper.init(message: R.string.localizable.sb_get_token_fail(), color: R.color.errorDark()!, duration: .middle).show()
        } catch ParseTokenException.InvalidKeyException {
            SnackBarHelper.init(message: R.string.localizable.sb_get_token_fail(), color: R.color.errorDark()!, duration: .middle).show()
        } catch ParseTokenException.IllegalStateException {
            SnackBarHelper.init(message: R.string.localizable.sb_get_token_fail(), color: R.color.errorDark()!, duration: .middle).show()
        } catch {
            SnackBarHelper.init(message: R.string.localizable.sb_get_token_fail(), color: R.color.errorDark()!, duration: .middle).show()
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
                    self?.view.tokenImported(card: card)
                }
            }
        }
        repository.update(card, onDone: onDataResponse)
    }
}
