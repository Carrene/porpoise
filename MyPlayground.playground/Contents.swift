import UIKit

var str = "Hello, playground"


protocol StoringType {
    associatedtype Stored
    
    init(_ value: Stored)
    func getStored() -> Stored
}

// An implementation that stores Ints
struct IntStorer: StoringType {
    typealias Stored = Int
    private let _stored: Int
    init(_ value: Int) { _stored = value }
    func getStored() -> Int { return _stored }
}

// An implementation that stores Strings
struct StringStorer: StoringType {
    typealias Stored = String
    private let _stored: String
    init(_ value: String) { _stored = value }
    func getStored() -> String { return _stored }
}
