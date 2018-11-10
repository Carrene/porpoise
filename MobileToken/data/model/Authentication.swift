//
//  Authentication.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/10/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//
import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class Authentication: Object, Mappable, NSCopying{
    
    static let PASSWORD = 0;
    static let PATTERN = 1;
    
    @objc fileprivate dynamic var Id: Int = 1
    public var id: Int {
        get { return Id }
        set { Id = newValue }
    }
    override class func primaryKey() -> String {
        return "Id"
    }
    
    fileprivate let AuthenticationType = RealmOptional<Int>()
    public var authenticationType: Int? {
        get { return AuthenticationType.value }
        set { AuthenticationType.value = newValue }
    }
    
    @objc fileprivate dynamic var AttemptsNumber: Int = 0
    fileprivate var attemptsNumber: Int {
        get { return AttemptsNumber }
        set { AttemptsNumber = newValue }
    }
    
    @objc fileprivate dynamic var Value: String? = nil
    public var credentials: String? {
        get { return Value }
        set { Value = newValue }
    }
    
    @objc fileprivate dynamic var MaxAttempts: Int = 5
    public var maxAttempts: Int { return MaxAttempts }
    
    private var authentication : Authentication?
    
    public var isLocked: Bool { return attemptsNumber >= maxAttempts }
    
    public var remainedAttempts: Int { return max(maxAttempts - attemptsNumber, 0) }
    
    private var JWT : String?
    //
    //    static let FILE_NAME = "MT-AUTHENTICATION";
    //    static let RECORD_ADDRESS = "AUTHENTICATION";
    //
    
    public func failAttempt() {
        attemptsNumber = attemptsNumber + 1
    }
    
    public func successAttempt() {
        if !isLocked { attemptsNumber = 0 }
    }
    
    public func unlock() {
        attemptsNumber = 0
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(credentials: String? = nil, authenticationType: Int? = nil) {
        self.init()
        self.credentials = credentials
        self.authenticationType = authenticationType
    }
    
    func mapping(map: Map) {
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
