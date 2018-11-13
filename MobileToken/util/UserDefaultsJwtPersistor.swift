//
//  UserDefaultsJwtPersistor.swift
//  alpha
//
//  Created by Arash Foumani on 7/11/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation

class UserDefaultsJwtPersistor: JwtPersistable {
    
    fileprivate var userDefaults: UserDefaults
    public let JWT_KEY: String = "JWT_KEY"
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func get() -> String? {
        return userDefaults.string(forKey: JWT_KEY)
    }
    
    func save(jwt: String) {
        userDefaults.set(jwt, forKey: JWT_KEY)
    }
    
    func delete() {
        userDefaults.removeObject(forKey: JWT_KEY)
    }
}
