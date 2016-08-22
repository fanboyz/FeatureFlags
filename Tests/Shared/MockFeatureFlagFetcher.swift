//
//  MockFeatureFlagFetcher.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation
#if FeatureFlagsUITests
    @testable import FeatureFlagsUI
#else
    @testable import FeatureFlags
#endif

class MockFeatureFlagFetcher: FeatureFlagFetcher {
    
    var didFetch = false
    var stubbedFeatureFlags = [FeatureFlag]()
    func fetch() -> [FeatureFlag] {
        didFetch = true
        return stubbedFeatureFlags
    }
}
