//
//  Feature.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public struct Feature: Equatable {
    public let key: String
    public let name: String
    
    public init(key: String, name: String) {
        self.key = key
        self.name = name
    }
}

public func ==(lhs: Feature, rhs: Feature) -> Bool {
    return lhs.key == rhs.key
        && lhs.name == rhs.name
}
