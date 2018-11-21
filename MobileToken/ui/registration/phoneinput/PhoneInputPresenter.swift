//
//  PhoneInputPresenter.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 8/29/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation

class PhoneInputPresenter : PhoneInputPresenterProtocol {
    
    var userRepostiory = UserRepository()

    unowned let view: PhoneInputViewProtocol
    
    required init(view: PhoneInputViewProtocol) {
        self.view = view
    }
    
    func claim(phone: String) {
        let user = User(phone: phone)
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] restRepoResponse in
            let statusCode = restRepoResponse.restDataResponse?.response?.statusCode
            switch statusCode {
            case 200:
                self?.view.navigateToPhoneConfirmation(phone:phone)
            case 400:
                self?.view.showBadRequestError()
            default:
                break
            }
        }
        userRepostiory.claim(user: user, onDone: onDataResponse)
    }
    
    func getBankList() {
        
    }
    
}
