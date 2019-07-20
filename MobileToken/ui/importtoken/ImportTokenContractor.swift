import Foundation

protocol ImportTokenViewProtocol: class {
    func tokenImported(card: Card)
    func showImportTokenError(message: String)
    func showInvalidChecksumError()
    func showExistTokenError()
    func showExistCardError()
}


protocol ImportTokenPresenterProtokol {
    init(view: ImportTokenViewProtocol)
    func importToken(tokenPacket: String, card: Card, cryptoModuleId: Token.CryptoModuleId)
    
}
