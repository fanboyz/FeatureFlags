//
//  MockFeatureFlagFetcher.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation
@testable import FeatureFlags

class MockFeatureFlagFetcher: FeatureFlagFetcher {
    
    var didFetch = false
    var stubbedFeatureFlags = [FeatureFlag]()
    func fetch() -> [FeatureFlag] {
        didFetch = true
        return stubbedFeatureFlags
    }
}
