//
//  FeatureFlagsUITests.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import XCTest
@testable import FeatureFlags

class FeatureFlagsUITests: XCTestCase {

    let file = NSURL(fileURLWithPath: NSTemporaryDirectory() + "test.plist")

    // MARK: - launch
    
    func test_launch_shouldReturnViewControllerWithMutator() {
        let viewController = FeatureFlagsUI.launch(sharedFeatureFlagFile: file) as? FeatureFlagsViewController
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.featureFlagsMutator)
    }
}
