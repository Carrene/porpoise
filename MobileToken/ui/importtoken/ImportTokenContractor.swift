import Foundation

protocol ImportTokenViewProtocol: class {
    func tokenImported(card: Card)
    func showImportTokenError(message: String)
    func showInvalidChecksumError()
    func showExistTokenAndCardError(card: Card, current token: Token)
    func showExistCardError(current card: Card)
}


protocol ImportTokenPresenterProtokol {
    init(view: ImportTokenViewProtocol)
    func importToken(tokenPacket: String, card: Card, cryptoModuleId: Token.CryptoModuleId)
    func updateCard(card: Card)
    func deleteToken(token: Token)
}
