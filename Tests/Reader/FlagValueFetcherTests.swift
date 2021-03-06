
import XCTest
@testable import FeatureFlags

class FlagValueFetcherTests: XCTestCase {
    
    var fetcher: FlagValueFetcher!
    var mockedFetcher: MockFeatureFlagFetcher!
    let flagKey = "flag"
    
    override func setUp() {
        super.setUp()
        mockedFetcher = MockFeatureFlagFetcher()
        fetcher = FlagValueFetcher(fetcher: mockedFetcher)
    }
    
    // MARK: - fetchValue(forKey:)
    
    func test_fetchValue_shouldReturnNil_whenNoMatchingFlag() {
        XCTAssertNil(fetcher.fetchValue(forKey: "nonexistent"))
    }
    
    func test_fetchValue_shouldReturnFalse_whenFlagIsFalse() {
        mockedFetcher.stubbedFeatureFlags = [falseFeatureFlag()]
        XCTAssertFalse(fetcher.fetchValue(forKey: flagKey) ?? true)
    }
    
    func test_fetchValue_shouldReturnTrue_whenFlagIsTrue() {
        mockedFetcher.stubbedFeatureFlags = [trueFeatureFlag()]
        XCTAssert(fetcher.fetchValue(forKey: flagKey) ?? false)
    }
    
    func test_fetchValue_shouldFindFlag_whenMultipleFlags() {
        mockedFetcher.stubbedFeatureFlags = [otherFeatureFlag(), otherFeatureFlag(), trueFeatureFlag()]
        XCTAssert(fetcher.fetchValue(forKey: flagKey) ?? false)
    }
    
    // MARK: - Helpers
    
    func falseFeatureFlag() -> FeatureFlag {
        return FeatureFlag(key: flagKey, name: "", value: false)
    }
    
    func trueFeatureFlag() -> FeatureFlag {
        return FeatureFlag(key: flagKey, name: "", value: true)
    }
    
    func otherFeatureFlag() -> FeatureFlag {
        return FeatureFlag(key: "other", name: "", value: false)
    }
}
