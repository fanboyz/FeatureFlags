//
//  FeatureFlagsUITests.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import XCTest
@testable import FeatureFlagsUI

class FeatureFlagsUITests: XCTestCase {
    
    var ui: FeatureFlagsUI!
    
    override func setUp() {
        super.setUp()
        ui = FeatureFlagsUI()
    }
    
    // MARK: - fetchFeatureFlags
    
    func test_fetchFeatureFlags_shouldFetchFeatureFlags() {
        XCTAssertEqual(ui.fetchFeatureFlags(), expected())
    }

    // MARK: - Helpers

    func expected() -> [FeatureFlag] {
        return []
    }
}
