
import Foundation
import TTGSnackbar
class ImportTokenPresenter: ImportTokenPresenterProtokol{
    
    unowned let view: ImportTokenViewProtocol

    required init(view: ImportTokenViewProtocol) {
        self.view = view
    }
    
    func importToken(tokenPacket: String, card: Card, cryptoModuleId: Token.CryptoModuleId) {
        
        let tokenRepository = TokenRepository()
        let onDataResponse: ((RepositoryResponse<Token>) -> ()) = { [weak self] response in
            var result = false
            if response.value == nil {
                let token = Token(tokenPaket: tokenPacket, card: card, cryptoModuleId: cryptoModuleId)
                do {
                    try token.validate()
                    card.TokenList.append(token)
                    let _ = token.parse()
                    card.number = token.name
                    self!.updateCard(card: card)
                    result = true
                    
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
                    
                } catch ParseTokenException.InvalidCardNumber {
                    SnackBarHelper.init(message: R.string.localizable.sb_tokenimport_invalidtokenname(), color: R.color.errorDark()!, duration: .middle).show()
                } catch {
                    SnackBarHelper.init(message: R.string.localizable.sb_get_token_fail(), color: R.color.errorDark()!, duration: .middle).show()
                }
            } else {
                SnackBarHelper.init(message: R.string.localizable.sb_tokenimport_duplicatetoken(), color: R.color.errorDark()!, duration: .middle).show()
            }
            Logger.instance.logEvent(event: ConstantHelper.IMPORT_TOKEN_LOG_EVENT, parameters: ["result": result as NSObject])
        }
        tokenRepository.get(identifier: tokenPacket, onDone: onDataResponse)
    
        
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
                    SnackBarHelper.init(message: R.string.localizable.sb_token_added(), color: R.color.snackbarColor()!, duration: .middle).show()
                    self?.view.tokenImported(card: card)
                }
            }
        }
        repository.update(card, onDone: onDataResponse)
    }
    
    func getToken(tokenPacket: String) {
        let tokenRepository = TokenRepository()
        let onDataResponse: ((RepositoryResponse<Token>) -> ()) = { response in
            if response.value != nil {
                //
            } else {
                //
            }
        }
        tokenRepository.get(identifier: tokenPacket, onDone: onDataResponse)
    }
    
    func validateAndSaveToken(tokenPacket: String) {
        
    }
}
