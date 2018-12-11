
import Foundation

class UserDefaultsJwtPersistor: JwtPersistable {
    
    private var userDefaults: UserDefaults
    public let JWT_KEY: String = "jwt"
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func get() -> String? {
        return userDefaults.string(forKey: JWT_KEY)
    }
    
    func get(identifier: String) -> String? {
        return userDefaults.string(forKey: JWT_KEY + identifier)

    }
    
    func getAll() -> [String]? {
        var jwtList = [String]()
        for element in userDefaults.dictionaryRepresentation() {
            if  element.key.hasPrefix(JWT_KEY) {
                jwtList.append(element.value as! String)
            }
        }
        return jwtList
    }
    
    func save(jwt: String) -> Bool? {
        userDefaults.set(jwt, forKey: JWT_KEY)
        return userDefaults.string(forKey: JWT_KEY) == jwt
    }
    
    func save(jwt: String, identifier: String) -> Bool? {
        userDefaults.set(jwt, forKey: JWT_KEY + identifier)
        return userDefaults.string(forKey: JWT_KEY + identifier) == jwt
    }
    
    func delete() -> Bool? {
        userDefaults.removeObject(forKey: JWT_KEY)
        return userDefaults.string(forKey: JWT_KEY) == nil
    }
    
    func delete(identifier: String) -> Bool? {
        userDefaults.removeObject(forKey: JWT_KEY + identifier)
        return userDefaults.string(forKey: JWT_KEY + identifier) == nil
    }
    
    func deleteAll() -> Bool? {
        for element in userDefaults.dictionaryRepresentation() {
            if element.key.hasPrefix(JWT_KEY) {
                userDefaults.removeObject(forKey: element.key)
                if userDefaults.string(forKey: element.key) != nil {
                    return false
                }
            }
        }
        return true
    }
    
    func size() -> Int? {
        var i = 0
        for element in userDefaults.dictionaryRepresentation() {
            if  element.key.hasPrefix(JWT_KEY) {
                i += 1
            }
        }
        return i
    }
    
    func getIdentifier(jwt: String) -> String? {
        for element in userDefaults.dictionaryRepresentation() {
            if element.value as! String == jwt {
                return element.key
            }
        }
        return nil
    }
    
    func contains(identifier: String) -> Bool? {
        return userDefaults.string(forKey: JWT_KEY + identifier) != nil
    }
}
