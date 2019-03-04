
import Foundation
import RealmSwift

class RealmConfiguration {
    
    static let insensitiveDataEncryptionKey = UIDevice.current.identifierForVendor!.uuidString.sha256()
    
    static var sensitiveDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"

    static var teptDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"
    
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
        print(config.encryptionKey?.toHexString())
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

