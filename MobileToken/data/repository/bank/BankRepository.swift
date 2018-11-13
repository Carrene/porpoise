//
//  BankRepository.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/22/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
class BankRepository: BankRepositoryProtocol {
    
    let bankRealmRepository = BanckRealmRepository()
    func get(identifier: Int, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[Bank]>) -> ())?) {
        bankRealmRepository.getAll() { realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
        onDone?(RepositoryResponse())
    }
    
    func update(_ bank: Bank, onDone: ((RepositoryResponse<Bank>) -> ())?) {
        bankRealmRepository.update(bank) {realmRepositoryResponse in
            onDone?(realmRepositoryResponse)
        }
    }
}
