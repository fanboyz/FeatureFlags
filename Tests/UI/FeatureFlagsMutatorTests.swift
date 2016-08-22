//
//  FeatureFlagsMutatorTests.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import XCTest
@testable import FeatureFlagsUI

class FeatureFlagsMutatorTests: XCTestCase {
    
    var mutator: FeatureFlagsMutator!
    var mockedFetcher: MockFeatureFlagFetcher!
    var mockedPersister: MockFeatureFlagPersister!
    let file = NSURL(fileURLWithPath: NSTemporaryDirectory() + "test.plist")

    override func setUp() {
        super.setUp()
        mockedFetcher = MockFeatureFlagFetcher()
        mockedPersister = MockFeatureFlagPersister()
        mutator = FeatureFlagsMutator(fetcher: mockedFetcher, persister: mockedPersister)
    }

    // MARK: - init(sharedFeatureFlagFile:)

    func test_init_shouldCreatePlistFetcherAndPersister() {
        mutator = FeatureFlagsMutator(sharedFeatureFlagFile: file)
        XCTAssert(mutator.fetcher is PlistFeatureFlagFetcher)
        XCTAssert(mutator.persister is PlistFeatureFlagPersister)
    }
    
    // MARK: - fetch
    
    func test_fetch_shouldFetchFeatureFlags() {
        mockedFetcher.stubbedFeatureFlags = expected()
        XCTAssertEqual(mutator.fetch(), expected())
    }

    // MARK: - persist

    func test_persist_shouldPersistFlags() {
        mutator.persist(expected())
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
