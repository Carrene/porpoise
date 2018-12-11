
import Foundation
import RealmSwift

class RealmConfiguration {
    
    private static let insensitiveDataEncryptionKey = "ehsanehsanehsanehsanehsanehsanehsanehsanehsanehsanehsanehsanhame"
    
    private static let sensitiveDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"
    
    public static var insensitiveDataConfiguration = Realm.Configuration(encryptionKey: insensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false))
    
    public static var sensitiveDataConfiguration = Realm.Configuration(encryptionKey: sensitiveDataEncryptionKey.data(using: String.Encoding.utf8, allowLossyConversion: false))
    public static var defaultDataConfiguration = Realm.Configuration.defaultConfiguration
}

