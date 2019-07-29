
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
                    if let card = self!.isCardExist(card: card) {
                        var i = 0
                        for t in card.TokenList {
                            t.card = card
                            let _ = t.parse()
                            t.card = nil
                            
                            if t.cryptoModuleId == token.cryptoModuleId {
                                    let currentToken = card.TokenList[i]
                                    card.TokenList.remove(at: i)
                                    card.TokenList.append(token)
                                    self?.view.showExistTokenAndCardError(card: card, current: currentToken)
                                    return
                            }
                            i += 1
                        }
                        card.TokenList.append(token)
                        self?.view.showExistCardError(current: card)
                        
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
    
    func isCardExist(card: Card) -> Card?  {
        var existCard: Card?
        let cardRepository = CardRepository()
        let onDataResponse: ((RepositoryResponse<[Card]>)->()) = { response in
            for dbCard in response.value! {
                let index = card.number?.index((card.number?.endIndex)!, offsetBy: -2)
                if dbCard.id != card.id, dbCard.number?[..<index!] == card.number![..<index!] {
                    //This card number exist in db and we did'nt need another one with this number, we romove this card's number and token (this token and numbr did'nt save to db yet) and we should add this token to "\(dbCard)"
                    card.TokenList.removeAll()
                    card.number = "________________"
                    existCard = dbCard
                    return
                }
            }
            
        }
        
        cardRepository.getAll(onDone: onDataResponse)
        return existCard
    }
    
    func deleteToken(token: Token) {
        let repository = TokenRepository()
        let onDataResponse : ((RepositoryResponse<Token>) -> ()) =  { [weak self] response in
            if response.error == nil {
                print("deleted")
            }
        }
        repository.delete(token: token, onDone: onDataResponse)
    }
}
