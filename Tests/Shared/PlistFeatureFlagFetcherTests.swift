//
//  FeatureFlagFetcherTests.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import XCTest
#if FeatureFlagsUITests
    @testable import FeatureFlagsUI
#else
    @testable import FeatureFlags
#endif

class FeatureFlagFetcherTests: XCTestCase {
    
    var fetcher: PlistFeatureFlagFetcher!
    
    override func setUp() {
        super.setUp()
    }
    
    // MARK: - fetch
    
    func test_fetch_shouldParseFeatureFlags() {
        loadValidFeatureFlagFetcher()
        XCTAssertEqual(fetcher.fetch(), expected())
    }
    
    func test_fetch_shouldReturnEmptyArray_whenNoFileExists() {
        loadNoFileFeatureFlagFetcher()
        XCTAssert(fetcher.fetch().isEmpty)
    }
    
    func test_fetch_shouldIgnoreBadPlistEntries() {
        loadPartiallyValidFeatureFlagFetcher()
        XCTAssertEqual(fetcher.fetch(), expected())
    }
    
    // MARK: - Helpers
    
    func loadValidFeatureFlagFetcher() {
        let file = NSBundle(forClass: FeatureFlagFetcherTests.self).URLForResource("TestFeatureFlags", withExtension: "plist")!
        fetcher = PlistFeatureFlagFetcher(file: file)
    }
    
    func loadNoFileFeatureFlagFetcher() {
        fetcher = PlistFeatureFlagFetcher(file: NSURL(fileURLWithPath: "hi"))
    }
    
    func loadPartiallyValidFeatureFlagFetcher() {
        let file = NSBundle(forClass: FeatureFlagFetcherTests.self).URLForResource("TestPartialFeatureFlags", withExtension: "plist")!
        fetcher = PlistFeatureFlagFetcher(file: file)
    }
    
    func expected() -> [FeatureFlag] {
        return [
            FeatureFlag(key: "aKey", name: "aName", value: true),
            FeatureFlag(key: "bKey", name: "bName", value: false)
        ]
    }
}
