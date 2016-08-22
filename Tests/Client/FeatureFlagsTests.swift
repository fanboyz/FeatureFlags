//
//  FeatureFlagsTests.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import XCTest
@testable import FeatureFlags

class FeatureFlagsTests: XCTestCase {
    
    var flags: FeatureFlags!
    
    override func setUp() {
        super.setUp()
        deleteSharedFile()
        flags = FeatureFlags(delegate: self)
    }
    
    // MARK: - init
    
    func test_init_shouldPreserverExistingValues() {
        turnFirstFeatureOn()
        flags = FeatureFlags(delegate: self)
        XCTAssert(flags.value(forFlag: "feature1"))
        XCTAssertFalse(flags.value(forFlag: "feature2"))
    }
    
    // MARK: - value(forFlag:)
    
    func test_valueForFlag_shouldGetValues() {
        XCTAssertFalse(flags.value(forFlag: "feature1"))
        XCTAssertFalse(flags.value(forFlag: "feature2"))
    }
    
    func test_valueForFlag_shouldBeFalse_whenNoFeature() {
        XCTAssertFalse(flags.value(forFlag: "nonexistent"))
    }
    
    func test_valueForFlag_shouldGetTrueValue() {
        turnFirstFeatureOn()
        XCTAssert(flags.value(forFlag: "feature1"))
        XCTAssertFalse(flags.value(forFlag: "feature2"))
    }
    
    // MARK: - Helpers
    
    func deleteSharedFile() {
        _ = try? NSFileManager.defaultManager().removeItemAtURL(sharedFeatureFlagFile)
    }
    
    func turnFirstFeatureOn() {
        let fetcher = PlistFeatureFlagFetcher(file: sharedFeatureFlagFile)
        let persister = PlistFeatureFlagPersister(file: sharedFeatureFlagFile)
        var features = fetcher.fetch()
        features[0].value = true
        persister.persist(features)
    }
}

extension FeatureFlagsTests: FeatureFlagsDelegate {
    
    var sharedFeatureFlagFile: NSURL {
        return NSURL(fileURLWithPath: NSTemporaryDirectory() + "test.plist")
    }
    
    var features: [Feature] {
        return [
            Feature(key: "feature1", name: "awesome feature!"),
            Feature(key: "feature2", name: "below average feature")
        ]
    }
}
