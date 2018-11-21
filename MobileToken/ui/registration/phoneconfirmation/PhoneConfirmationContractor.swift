//
//  PhoneConfirmationContractor.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 8/30/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation

protocol PhoneConfirmationViewProtocol:class {
    func showBadRequestError()
    func showSSMNotAvailable()
    func segue()
}

protocol PhoneConfirmationPresenterProtocol {
    init(view:PhoneConfirmationViewProtocol)
    func bind(phone:String,activationCode:String)
}
