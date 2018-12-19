//
//  AuthenticationDefinitionPresenter.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 9/17/1397 AP.
//  Copyright © 1397 tosan.ir. All rights reserved.
//

import Foundation
class AuthenticationDefinitionPresenter: AuthenticationDefinitionPresenterProtocol {
    
    unowned let authenticationDefinitionView: AuthenticationDefinitionViewProtocol
    
    required init(authenticationDefinitionView: AuthenticationDefinitionViewProtocol) {
        self.authenticationDefinitionView = authenticationDefinitionView
    }
}
