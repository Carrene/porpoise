//
//  PhoneInputcontractor.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 8/29/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation

    protocol PhoneInputViewProtocol: class {
        func showBadRequestError()
        func setBankList(bankList:[Bank])
        func navigateToPhoneConfirmation(phone:String)
    }

    protocol PhoneInputPresenterProtocol {
        init(view: PhoneInputViewProtocol)
        func claim(phone: String)
        func getBankList()
    }

