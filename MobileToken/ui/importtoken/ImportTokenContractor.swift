import Foundation

protocol ImportTokenViewProtocol: class {
    func set(card: Card)
}


protocol ImportTokenPresenterProtokol {
    init(view: ImportTokenViewProtocol)
    func importToken(tokenPacket: String, card: Card)
}
