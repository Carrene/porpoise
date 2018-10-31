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
    
    private static let insensitiveDataEncryptionKey = "ehsanehsanehsanehsanehsanehsanehsanehsanehsanehsanehsanehsanhame"
    
    private static let sensitiveDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"
    
    public static var insensitiveDataConfiguration = Realm.Configuration(encryptionKey: insensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false))
    
    public static var sensitiveDataConfiguration = Realm.Configuration(encryptionKey: sensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false))
    public static var defaultDataConfiguration = Realm.Configuration.defaultConfiguration
}

