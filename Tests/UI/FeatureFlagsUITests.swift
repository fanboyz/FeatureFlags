//
//  FeatureFlagsUITests.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import XCTest
@testable import FeatureFlagsUI

class FeatureFlagsUITests: XCTestCase {
    
    var ui: FeatureFlagsUI!
    var mockedFetcher: MockFeatureFlagFetcher!
    var mockedPersister: MockFeatureFlagPersister!
    let file =
    NSURL(fileURLWithPath: NSTemporaryDirectory() + "test.plist")

    override func setUp() {
        super.setUp()
        mockedFetcher = MockFeatureFlagFetcher()
        mockedPersister = MockFeatureFlagPersister()
        ui = FeatureFlagsUI(fetcher: mockedFetcher, persister: mockedPersister)
    }

    // MARK: - init(sharedFeatureFlagFile:)

    func test_init_shouldCreatePlistFetcherAndPersister() {
        ui = FeatureFlagsUI(sharedFeatureFlagFile: file)
        XCTAssert(ui.fetcher is PlistFeatureFlagFetcher)
        XCTAssert(ui.persister is PlistFeatureFlagPersister)
    }
    
    // MARK: - fetch
    
    func test_fetch_shouldFetchFeatureFlags() {
        mockedFetcher.stubbedFeatureFlags = expected()
        XCTAssertEqual(ui.fetch(), expected())
    }

    // MARK: - persist

    func test_persist_shouldPersistFlags() {
        ui.persist(expected())
        XCTAssertEqual(mockedPersister.invokedFeatureFlags!, expected())
    }

    // MARK: - Helpers

    func expected() -> [FeatureFlag] {
        return [
            FeatureFlag(key: "feature1", name: "Feature 1", value: false),
            FeatureFlag(key: "feature2", name: "Feature 2", value: false)
        ]
    }
}
