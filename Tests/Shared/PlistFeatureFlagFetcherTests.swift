
import XCTest
@testable import FeatureFlags

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

    func test_fetch_shouldFetchFlagWithoutDefaultValue_andSetToFalse() {
        loadNoDefaultValueFeatureFlagFetcher()
        XCTAssertEqual(fetcher.fetch(), expectedNoDefaultValueFeatureFlags())
    }
    
    // MARK: - Helpers
    
    func loadValidFeatureFlagFetcher() {
        let file = Bundle(for: FeatureFlagFetcherTests.self).url(forResource: "TestFeatureFlags", withExtension: "plist")!
        fetcher = PlistFeatureFlagFetcher(file: file)
    }
    
    func loadNoFileFeatureFlagFetcher() {
        fetcher = PlistFeatureFlagFetcher(file: URL(fileURLWithPath: "hi"))
    }
    
    func loadPartiallyValidFeatureFlagFetcher() {
        let file = Bundle(for: FeatureFlagFetcherTests.self).url(forResource: "TestPartialFeatureFlags", withExtension: "plist")!
        fetcher = PlistFeatureFlagFetcher(file: file)
    }

    func loadNoDefaultValueFeatureFlagFetcher() {
        let file = Bundle(for: FeatureFlagFetcherTests.self).url(forResource: "TestNoDefaultValueFeatureFlags", withExtension: "plist")!
        fetcher = PlistFeatureFlagFetcher(file: file)
    }
    
    func expected() -> [FeatureFlag] {
        return [
            FeatureFlag(key: "aKey", name: "aName", value: true),
            FeatureFlag(key: "bKey", name: "bName", value: false, defaultValue: true)
        ]
    }

    func expectedNoDefaultValueFeatureFlags() -> [FeatureFlag] {
        return [
            FeatureFlag(key: "aKey", name: "aName", value: true),
            FeatureFlag(key: "bKey", name: "bName", value: false)
        ]
    }
}
