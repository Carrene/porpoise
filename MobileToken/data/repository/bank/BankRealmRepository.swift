import Foundation
import RealmSwift

class BankRealmRepository: BankRepositoryProtocol {
    
    func get(card: Card, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Bank]>) -> ())?) {
        var banks = [Bank]()
        let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
        let bankRealmResult = realm.objects(Bank.self)
        for j in  0 ..< bankRealmResult.count {
            let bank = bankRealmResult[j].detached()
            for i in 0 ..< bank.CardList.count {
                bank.CardList[i].bank = bank
            }
            banks.append(bank)
        }
   
        onDone?(RepositoryResponse(value: banks))
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





protocol DetachableObject: AnyObject {
    func detached() -> Self
}

extension Object: DetachableObject {
    
    func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            
            if property.isArray == true {
                //Realm List property support
                let detachable = value as? DetachableObject
                detached.setValue(detachable?.detached(), forKey: property.name)
            } else if property.type == .object {
                //Realm Object property support
                let detachable = value as? DetachableObject
                detached.setValue(detachable?.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}

extension List: DetachableObject {
    func detached() -> List<Element> {
        let result = List<Element>()
        
        forEach {
            if let detachable = $0 as? DetachableObject {
                let detached = detachable.detached() as! Element
                result.append(detached)
            } else {
                result.append($0) //Primtives are pass by value; don't need to recreate
            }
        }
        
        return result
    }
    
    func toArray() -> [Element] {
        return Array(self.detached())
    }
}

extension Results {
    func toArray() -> [Element] {
        let result = List<Element>()
        
        forEach {
            result.append($0)
        }
        
        return Array(result.detached())
    }
}
