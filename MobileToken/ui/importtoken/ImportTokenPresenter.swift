
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
                    if let card = self!.isCardValid(card: card) {
                        for t in card.TokenList {
                            t.parse()
                            if t.cryptoModuleId == token.cryptoModuleId {
                                
                            }
                        }
                    }else {
                        self!.updateCard(card: card)
                        result = true
                    }
                    
                } catch ParseTokenException.InvalidChecksumException{
                    self?.view.showInvalidChecksumError()
                } catch ParseTokenException.InvalidBankIdException {
                    self?.view.showImportTokenError(message: R.string.localizable.sb_tokenimport_invalidbankid())
                } catch ParseTokenException.InvalidCryptoModuleIdException {
                    self?.view.showImportTokenError(message: R.string.localizable.sb_tokenimport_invalidcryptomoduleid())
                } catch ParseTokenException.NumberFormatException {
                    self?.view.showImportTokenError(message: R.string.localizable.sb_get_token_fail())
                } catch ParseTokenException.InvalidKeyException {
                     self?.view.showImportTokenError(message: R.string.localizable.sb_get_token_fail())
                } catch ParseTokenException.InvalidKeyException {
                    self?.view.showImportTokenError(message: R.string.localizable.sb_get_token_fail())
                } catch ParseTokenException.IllegalStateException {
                    self?.view.showImportTokenError(message: R.string.localizable.sb_get_token_fail())
                    
                } catch ParseTokenException.InvalidCardNumber {
                    self?.view.showImportTokenError(message: R.string.localizable.sb_tokenimport_invalidtokenname())
                } catch {
                     self?.view.showImportTokenError(message: R.string.localizable.sb_get_token_fail())
                }
            } else {
                self?.view.showImportTokenError(message: R.string.localizable.sb_tokenimport_duplicatetoken())
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
    
    func isCardValid(card: Card) -> Card?  {
        var existCard: Card?
        let cardRepository = CardRepository()
        let onDataResponse: ((RepositoryResponse<[Card]>)->()) = { response in
            for dbCard in response.value! {
                
                if dbCard.id != card.id, dbCard.number == card.number {
                    existCard = dbCard
                    return
                }
            }
            
        }
        
        cardRepository.getAll(onDone: onDataResponse)
        return existCard
    }
}
