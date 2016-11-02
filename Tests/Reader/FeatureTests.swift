
import XCTest
@testable import FeatureFlags

class FeatureTests: XCTestCase {

    func test_defaultValue_shouldBeFalse_byDefault() {
        let feature = Feature(key: "", name: "")
        XCTAssertFalse(feature.defaultValue)
    }
    
    // MARK: - ==
    
    func test_shouldBeEqual_whenPropertiesMatch() {
        XCTAssertEqual(create(), create())
    }
    
    func test_shouldNotBeEqual_whenPropertiesAreDifferent() {
        XCTAssertNotEqual(create(), create(key: "wrong"))
        XCTAssertNotEqual(create(), create(name: "wrong"))
        XCTAssertNotEqual(create(), create(defaultValue: true))
    }
    
    // MARK: - Helpers
    
    func create(
        key: String = "key",
        name: String = "name",
        defaultValue: Bool = false
    ) -> Feature {
        return Feature(key: key, name: name, defaultValue: defaultValue)
    }
}
