
import XCTest
@testable import FeatureFlags

class FeatureFlagTests: XCTestCase {
    
    // MARK: - ==
    
    func test_shouldBeEqual_whenPropertiesMatch() {
        XCTAssertEqual(create(), create())
    }
    
    func test_shouldNotBeEqual_whenPropertiesAreDiffernt() {
        XCTAssertNotEqual(create(), create(key: "wrong"))
        XCTAssertNotEqual(create(), create(name: "wrong"))
        XCTAssertNotEqual(create(), create(value: true))
    }
    
    // MARK: - Helpers
    
    func create(
        key: String = "key",
        name: String = "name",
        value: Bool = false
    ) -> FeatureFlag {
        return FeatureFlag(key: key, name: name, value: value)
    }
}
