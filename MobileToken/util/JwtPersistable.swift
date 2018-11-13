//
//  JwtPersistable.swift
//  alpha
//
//  Created by Arash Foumani on 7/11/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation

public protocol JwtPersistable {
    
    func get() -> String?
    func save(jwt: String)
    func delete()
}
