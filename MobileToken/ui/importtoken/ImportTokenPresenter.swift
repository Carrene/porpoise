
import Foundation
class ImportTokenPresenter: ImportTokenPresenterProtokol{
    
    unowned let view: ImportTokenViewProtocol

    required init(view: ImportTokenViewProtocol) {
        self.view = view
    }
    
    func importToken(tokenPacket: String, card: Card) {
        
    }
    
    func getManagedCard(id: String) {
        let cardRepository = CardRepository()
        let onDataResponse : ((RepositoryResponse<Card>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
                
                self!.view.setManagedCard(card: response.value!)
            }
        }
        cardRepository.get(identifier: id, onDone: onDataResponse)
        
    }
}
