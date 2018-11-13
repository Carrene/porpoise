//
//  BankRealmRepository.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/22/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import RealmSwift
class BanckRealmRepository: BankRepositoryProtocol {
    func get(identifier: Int, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Bank]>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration)
        let bankRealmResult: [Bank]? = realm.objects(Bank.self).map {$0.copy() as! Bank}
        if bankRealmResult == nil {
            onDone?(RepositoryResponse(value: nil))
        } else {
            onDone?(RepositoryResponse(value: bankRealmResult))
        }
    }
    
    func update(_ bank: Bank, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        let realm = try! Realm(configuration: RealmConfiguration.insensitiveDataConfiguration)
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
