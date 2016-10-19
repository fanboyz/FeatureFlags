
import XCTest
@testable import FeatureFlags

class FeatureTests: XCTestCase {
    
    // MARK: - ==
    
    func test_shouldBeEqual_whenPropertiesMatch() {
        XCTAssertEqual(create(), create())
    }
    
    func test_shouldNotBeEqual_whenKeysAreDifferent() {
        XCTAssertNotEqual(create(), create(key: "wrong"))
    }
    
    func test_shouldNotBeEqual_whenNamesAreDifferent() {
        XCTAssertNotEqual(create(), create(name: "wrong"))
    }
    
    // MARK: - Helpers
    
    func create(
        key: String = "key",
        name: String = "name"
    ) -> Feature {
        return Feature(key: key, name: name)
    }
}
