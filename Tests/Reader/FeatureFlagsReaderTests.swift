
import XCTest
@testable import FeatureFlags

class FeatureFlagsReaderTests: XCTestCase {
    
    var reader: FeatureFlagsReader!
    let feature1 = Feature(key: "feature1", name: "awesome feature!")
    let feature2 = Feature(key: "feature2", name: "below average feature")
    let nonExistentFeature = Feature(key: "", name: "")
    
    override func setUp() {
        super.setUp()
        deleteSharedFile()
        reader = FeatureFlagsReader(delegate: self)
    }
    
    // MARK: - init
    
    func test_init_shouldPreserverExistingValues() {
        turnFirstFeatureOn()
        reader = FeatureFlagsReader(delegate: self)
        XCTAssert(reader.value(for: feature1))
        XCTAssertFalse(reader.value(for: feature2))
    }
    
    // MARK: - value(for:)
    
    func test_valueForFlag_shouldGetValues() {
        XCTAssertFalse(reader.value(for: feature1))
        XCTAssertFalse(reader.value(for: feature2))
    }
    
    func test_valueForFlag_shouldBeFalse_whenNoFeature() {
        XCTAssertFalse(reader.value(for: nonExistentFeature))
    }
    
    func test_valueForFlag_shouldGetTrueValue() {
        turnFirstFeatureOn()
        XCTAssert(reader.value(for: feature1))
        XCTAssertFalse(reader.value(for: feature2))
    }
    
    // MARK: - Helpers
    
    func deleteSharedFile() {
        try? FileManager.default.removeItem(at: sharedFeatureFlagFile)
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
    
    var sharedFeatureFlagFile: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory() + "test.plist")
    }
    
    var features: [Feature] {
        return [
            feature1,
            feature2
        ]
    }
}
