import Foundation

protocol ImportTokenViewProtocol: class {
}


protocol ImportTokenPresenterProtokol {
    init(view: ImportTokenViewProtocol)
    func importToken(tokenPacket: String, card: Card)
}
