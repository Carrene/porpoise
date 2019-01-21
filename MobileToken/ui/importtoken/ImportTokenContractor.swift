import Foundation

protocol ImportTokenViewProtocol: class {
    func setManagedCard(card: Card)
}


protocol ImportTokenPresenterProtokol {
    init(view: ImportTokenViewProtocol)
    func importToken(tokenPacket: String, card: Card)
    func getManagedCard(id: String)
}
