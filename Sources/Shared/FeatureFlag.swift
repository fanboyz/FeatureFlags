
import Foundation

struct FeatureFlag: Equatable {
    let key: String
    let name: String
    var value: Bool
    var defaultValue: Bool

    init(key: String, name: String, value: Bool, defaultValue: Bool = false) {
        self.key = key
        self.name = name
        self.value = value
        self.defaultValue = defaultValue
    }
}

func ==(lhs: FeatureFlag, rhs: FeatureFlag) -> Bool {
    return lhs.key == rhs.key
        && lhs.name == rhs.name
        && lhs.value == rhs.value
        && lhs.defaultValue == rhs.defaultValue
}
