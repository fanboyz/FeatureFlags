//
//  MockFeatureFlagPersister.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation
#if FeatureFlagsUITests
    @testable import FeatureFlagsUI
#else
    @testable import FeatureFlags
#endif

class MockFeatureFlagPersister: FeatureFlagPersister {
    
    var didPersist = false
    var invokedFeatureFlags: [FeatureFlag]?
    func persist(featureFlags: [FeatureFlag]) {
        didPersist = true
        invokedFeatureFlags = featureFlags
    }
}
