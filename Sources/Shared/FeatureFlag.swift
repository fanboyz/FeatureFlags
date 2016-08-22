//
//  FeatureFlag.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public struct FeatureFlag: Equatable {
    public let key: String
    public let name: String
    public var value: Bool

    public init(key: String, name: String, value: Bool) {
        self.key = key
        self.name = name
        self.value = value
    }
}

public func ==(lhs: FeatureFlag, rhs: FeatureFlag) -> Bool {
    return lhs.key == rhs.key
        && lhs.name == rhs.name
        && lhs.value == rhs.value
}
