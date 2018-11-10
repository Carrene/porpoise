//
//  AuthenticationRepository.swift
//  alpha
//
//  Created by Arash Foumani on 6/27/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation

protocol AuthenticationRepository: Repository where Model == Authentication, Identifier == Int {
    
    func get(onDone: ((RepositoryResponse<Model>) -> ())?)
}
