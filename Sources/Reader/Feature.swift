
import Foundation

public struct Feature: Equatable {
    public let key: String
    public let name: String
    public let defaultValue: Bool
    
    public init(key: String, name: String, defaultValue: Bool = false) {
        self.key = key
        self.name = name
        self.defaultValue = defaultValue
    }
}

public func ==(lhs: Feature, rhs: Feature) -> Bool {
    return lhs.key == rhs.key
        && lhs.name == rhs.name
        && lhs.defaultValue == rhs.defaultValue
}
