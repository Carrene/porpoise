//
//  Token.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/21/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Token: Object, Mappable, NSCopying{
    
    @objc fileprivate dynamic var TokenPaket: String? = nil
    public var tokenPaket: String? {
        get { return TokenPaket }
        set { TokenPaket = newValue }
    }
    
    private var expireDate: String?
    
    private var cryptoModuleId: Int?
    
    private var seed: [UInt8]?
    
    private var name: String?
    
//    private var hashType: HashType?
    
    private var version: Int?
    
    private var timeInterval: Int?
    
    private var otpLength: Int?
    
    private var secret: String?
    
    required convenience init(map: Map) {
        self.init()
    }
    
    convenience init(tokenPaket: String? = nil, secret: String? = nil) {
        self.init()
        self.tokenPaket = tokenPaket
        
        self.secret = secret
        
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Token(tokenPaket: tokenPaket, secret: secret)
    }
}
