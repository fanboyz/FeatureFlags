
import Foundation

struct FeatureFlag: Equatable {
    let key: String
    let name: String
    var value: Bool
}

func ==(lhs: FeatureFlag, rhs: FeatureFlag) -> Bool {
    return lhs.key == rhs.key
        && lhs.name == rhs.name
        && lhs.value == rhs.value
}
