import Foundation
import RealmSwift

class BankRealmRepository: BankRepositoryProtocol {
    
    func get(card: Card, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Bank]>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        let bankRealmResult = realm.objects(Bank.self)       
        for bank in bankRealmResult {
            for card in bank.cardList {
                card.bank = (card.owner.first!.copy() as! Bank)
            }
        }
        
        onDone?(RepositoryResponse(value: bankRealmResult.map{$0.copy() as! Bank}))
    }
    
    func update(_ bank: Bank, onDone: ((RepositoryResponse<Bank>) -> ())?) {
         let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        do {
            try realm.write {
                realm.add(bank.copy() as! Bank, update: true)
            }
            onDone?(RepositoryResponse(value: bank.copy() as? Bank))
        }
        catch {
            onDone?(RepositoryResponse(error: error))
        }
    }
}
