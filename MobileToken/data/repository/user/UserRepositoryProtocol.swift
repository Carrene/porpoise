//
//  UserRepository.swift
//  alpha
//
//  Created by Arash Foumani on 7/2/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation

protocol UserRepositoryProtocol: Repository where Model == User, Identifier == Int{
    func bind(user: User, onDone: ((RepositoryResponse<User>) -> ())?)
    func claim(user: User, onDone: ((RepositoryResponse<User>) -> ())?)
}
