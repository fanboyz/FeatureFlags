
import XCTest
@testable import FeatureFlags

class PlistFeatureFlagPersisterTests: XCTestCase {
    
    var persister: PlistFeatureFlagPersister!
    var fetcher: PlistFeatureFlagFetcher!
    let file = NSURL(fileURLWithPath: NSTemporaryDirectory() + "flags")
    
    override func setUp() {
        super.setUp()
        persister = PlistFeatureFlagPersister(file: file)
        fetcher = PlistFeatureFlagFetcher(file: file)
    }
    
    override func tearDown() {
        _ = try? NSFileManager.defaultManager().removeItemAtURL(file)
        super.tearDown()
    }
    
    // MARK: - persist
    
    func test_persist() {
        persister.persist(featureFlags())
        XCTAssertEqual(fetcher.fetch(), featureFlags())
    }
    
    // MARK: - Helpers
    
    func featureFlags() -> [FeatureFlag] {
        return [
            FeatureFlag(key: "aKey", name: "aName", value: true),
            FeatureFlag(key: "bKey", name: "bName", value: false)
        ]
    }
}
