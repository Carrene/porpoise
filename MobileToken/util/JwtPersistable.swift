

import Foundation

public protocol JwtPersistable {
    
    func get() -> String?
    func get(identifier: String) -> String?
    func getAll() -> [String]?
    func save(jwt: String) -> Bool?
    func save(jwt: String, identifier: String) -> Bool?
    func delete() -> Bool?
    func delete(identifier: String) -> Bool?
    func deleteAll() -> Bool?
    func size() -> Int?
    func getIdentifier(jwt: String) -> String?
    func contains(identifier: String) -> Bool?
}
