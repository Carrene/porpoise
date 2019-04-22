
import Foundation
import RealmSwift
import KeychainSwift

class RealmConfiguration {
    
    static let insensitiveDataEncryptionKey = UIDevice.current.identifierForVendor!.uuidString.sha256()
    
    static var sensitiveDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"

    static var teptDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"
    
    public static var defaultDataConfiguration = Realm.Configuration.defaultConfiguration
    
    
    static func insensitiveDataConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("insensitive.realm")
//        let key = insensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let keychain = KeychainSwift()
        let key = keychain.getData("my key")
        print(type(of: key))
        config.encryptionKey = key
        return config
    }
    
    static func sensitiveDataConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("sensitive.realm")
        let key = sensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false)
        config.encryptionKey = key
        return config
    }
    
    static func temptDataConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("tempt.realm")
        config.encryptionKey = teptDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false)
        return config
    }
    
    static func realmMainSensitiveConfiguration() -> Realm.Configuration {
        if isTemptDbExist() {
            return temptDataConfiguration()
        } else {
            return sensitiveDataConfiguration()
        }
    }
    
    static func isTemptDbExist() -> Bool {
        let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
        let fooURL = documentsURL.appendingPathComponent("tempt.realm")
        return FileManager().fileExists(atPath: fooURL.path)
    }
}

