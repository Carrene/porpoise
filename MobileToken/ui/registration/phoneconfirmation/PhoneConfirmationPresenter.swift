//
//  PhoneConfirmationPresenter.swift
//  
//
//  Created by Fateme' Kazemi on 8/30/1397 AP.
//

import Foundation

class PhoneConfirmationPresenter:PhoneConfirmationPresenterProtocol {
    
    unowned let view : PhoneConfirmationViewProtocol
    var userRepository = UserRepository()
    
    required init(view: PhoneConfirmationViewProtocol) {
        self.view = view
    }
    
    func bind(phone:String,activationCode:String) {
        let user = User(phone: phone, activationCode: activationCode)
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] restRepoResponse in
            let statusCode = restRepoResponse.restDataResponse?.response?.statusCode
            switch statusCode {
            case 200:
                self?.view.segue()
            case 400:
                self?.view.showBadRequestError()
            case 801:
                self?.view.showSSMNotAvailable()
            default:
                UIHelper.showFailedSnackBar()
            }
        }
        userRepository.bind(user: user, onDone: onDataResponse)
    }
}