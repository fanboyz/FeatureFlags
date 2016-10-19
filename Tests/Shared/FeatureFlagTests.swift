
import XCTest
@testable import FeatureFlags

class FeatureFlagTests: XCTestCase {
    
    // MARK: - ==
    
    func test_shouldBeEqual_whenPropertiesMatch() {
        XCTAssertEqual(create(), create())
    }
    
    func test_shouldNotBeEqual_whenKeysAreDiffernt() {
        XCTAssertNotEqual(create(), create(key: "wrong"))
    }
    
    func test_shouldNotBeEqual_whenNamesAreDiffernt() {
        XCTAssertNotEqual(create(), create(name: "wrong"))
    }
    
    func test_shouldNotBeEqual_whenValuesAreDiffernt() {
        XCTAssertNotEqual(create(), create(value: true))
    }
    
    // MARK: - Helpers
    
    func create(
        key key: String = "key",
        name: String = "name",
        value: Bool = false
    ) -> FeatureFlag {
        return FeatureFlag(key: key, name: name, value: value)
    }
}
