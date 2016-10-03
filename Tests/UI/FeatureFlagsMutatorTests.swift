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
        mockedFetcher.stubbedFeatureFlags = featureFlags()
        XCTAssertEqual(mutator.fetch(), featureFlags())
    }

    // MARK: - persist

    func test_persist_shouldPersistFlags() {
        mutator.persist(featureFlags())
        XCTAssertEqual(mockedPersister.invokedFeatureFlags!, featureFlags())
    }

    // MARK: - update(_,to:)

    func test_update_shouldChangeValueOfFeatures() {
        stubFeatureFlags(false, false)
        update(at: 0, to: true)
        assertFlags(true, false)

        stubFeatureFlags(false, false)
        update(at: 1, to: true)
        assertFlags(false, true)

        stubFeatureFlags(true, true)
        update(at: 0, to: false)
        assertFlags(false, true)
    }

    // MARK: - Helpers

    func featureFlags() -> [FeatureFlag] {
        return [
            FeatureFlag(key: "feature1", name: "Feature 1", value: false),
            FeatureFlag(key: "feature2", name: "Feature 2", value: false)
        ]
    }

    func stubFeatureFlags(values: Bool...) {
        mockedFetcher.stubbedFeatureFlags = values.map { value in
            FeatureFlag(key: NSUUID().UUIDString, name: "", value: value)
        }
    }

    func update(at index: Int, to value: Bool) {
        mutator.update(mockedFetcher.stubbedFeatureFlags[index], to: value)
    }

    func assertFlags(values: Bool..., file: StaticString = #file, line: UInt = #line) {
        for (i, value) in values.enumerate() {
            XCTAssertEqual(value, persistedFeatureFlags()[i].value, file: file, line: line)
        }
    }

    func persistedFeatureFlags() -> [FeatureFlag] {
        return mockedPersister.invokedFeatureFlags!
    }
}
