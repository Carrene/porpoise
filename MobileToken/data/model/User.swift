//
//  User.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/10/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Object, Mappable, NSCopying {
    
    @objc private dynamic var Phone: String?
    public var phone: String? {
        get { return Phone }
        set { Phone = newValue }
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init( phone: String? = nil) {
        self.init()
        self.phone = phone
    }
    
    func mapping(map: Map) {
        map.shouldIncludeNilValues = true
        self.phone <- map["phone"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return User(phone: phone)
    }
    
}
