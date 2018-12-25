//
//  RealmConfiguration.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/9/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfiguration {
    
    static let insensitiveDataEncryptionKey = UIDevice.current.identifierForVendor!.uuidString.sha256()
    
    static var sensitiveDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"

    public static var defaultDataConfiguration = Realm.Configuration.defaultConfiguration
    
    
    static func insensitiveDataConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("insensitive.realm")
        config.encryptionKey = insensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false)
        return config
    }
    
    static func sensitiveDataConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("sensitive.realm")
        config.encryptionKey = sensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false)
//        print("keyyy"+(config.encryptionKey?.toHexString())!)
        return config
    }
}

