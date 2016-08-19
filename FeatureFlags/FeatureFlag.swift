//
//  FeatureFlag.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public struct FeatureFlag: Equatable {
    let key: String
    let name: String
    var value: Bool
}

public func ==(lhs: FeatureFlag, rhs: FeatureFlag) -> Bool {
    return lhs.key == rhs.key
        && lhs.name == rhs.name
        && lhs.value == rhs.value
}
