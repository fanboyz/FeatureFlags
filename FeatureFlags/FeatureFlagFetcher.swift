//
//  FeatureFlagFetcher.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public protocol FeatureFlagFetcher {
    func fetch() -> [FeatureFlag]
}
