import Foundation

protocol ImportTokenViewProtocol: class {
    func tokenImported(card: Card)
}


protocol ImportTokenPresenterProtokol {
    init(view: ImportTokenViewProtocol)
    func importToken(tokenPacket: String, card: Card, cryptoModuleId: Token.CryptoModuleId)
    
}
