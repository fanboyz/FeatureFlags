
import XCTest
@testable import FeatureFlags

class FeatureFlagsReaderTests: XCTestCase {
    
    var reader: FeatureFlagsReader!
    
    override func setUp() {
        super.setUp()
        deleteSharedFile()
        reader = FeatureFlagsReader(delegate: self)
    }
    
    // MARK: - init
    
    func test_init_shouldPreserverExistingValues() {
        turnFirstFeatureOn()
        reader = FeatureFlagsReader(delegate: self)
        XCTAssert(reader.value(forFlag: "feature1"))
        XCTAssertFalse(reader.value(forFlag: "feature2"))
    }
    
    // MARK: - value(forFlag:)
    
    func test_valueForFlag_shouldGetValues() {
        XCTAssertFalse(reader.value(forFlag: "feature1"))
        XCTAssertFalse(reader.value(forFlag: "feature2"))
    }
    
    func test_valueForFlag_shouldBeFalse_whenNoFeature() {
        XCTAssertFalse(reader.value(forFlag: "nonexistent"))
    }
    
    func test_valueForFlag_shouldGetTrueValue() {
        turnFirstFeatureOn()
        XCTAssert(reader.value(forFlag: "feature1"))
        XCTAssertFalse(reader.value(forFlag: "feature2"))
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

extension FeatureFlagsReaderTests: FeatureFlagsReaderDelegate {
    
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
