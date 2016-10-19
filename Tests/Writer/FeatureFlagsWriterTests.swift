
import XCTest
@testable import FeatureFlags

class FeatureFlagsWriterTests: XCTestCase {
    
    var writer: FeatureFlagsWriter!
    var mockedFetcher: MockFeatureFlagFetcher!
    var mockedPersister: MockFeatureFlagPersister!
    let file = URL(fileURLWithPath: NSTemporaryDirectory() + "test.plist")

    override func setUp() {
        super.setUp()
        mockedFetcher = MockFeatureFlagFetcher()
        mockedPersister = MockFeatureFlagPersister()
        writer = FeatureFlagsWriter(fetcher: mockedFetcher, persister: mockedPersister)
    }

    // MARK: - init(sharedFeatureFlagFile:)

    func test_init_shouldCreatePlistFetcherAndPersister() {
        writer = FeatureFlagsWriter(sharedFeatureFlagFile: file)
        XCTAssert(writer.fetcher is PlistFeatureFlagFetcher)
        XCTAssert(writer.persister is PlistFeatureFlagPersister)
    }
    
    // MARK: - fetch
    
    func test_fetch_shouldFetchFeatureFlags() {
        mockedFetcher.stubbedFeatureFlags = featureFlags()
        XCTAssertEqual(writer.fetch(), featureFlags())
    }

    // MARK: - update(_,to:)

    func test_update_shouldChangeValueOfFeatures() {
        stubFeatureFlags(false, false)
        update(at: 0, to: true)
        assertFlags(true, false)

        stubFeatureFlags(false, false)
        update(at: 1, to: true)
        assertFlags(false, true)

        stubFeatureFlags(true, true)
        update(at: 0, to: false)
        assertFlags(false, true)
    }

    // MARK: - Helpers

    func featureFlags() -> [FeatureFlag] {
        return [
            FeatureFlag(key: "feature1", name: "Feature 1", value: false),
            FeatureFlag(key: "feature2", name: "Feature 2", value: false)
        ]
    }

    func stubFeatureFlags(_ values: Bool...) {
        mockedFetcher.stubbedFeatureFlags = values.map { value in
            FeatureFlag(key: UUID().uuidString, name: "", value: value)
        }
    }

    func update(at index: Int, to value: Bool) {
        writer.update(key: mockedFetcher.stubbedFeatureFlags[index].key, to: value)
    }

    func assertFlags(_ values: Bool..., file: StaticString = #file, line: UInt = #line) {
        for (i, value) in values.enumerated() {
            XCTAssertEqual(value, persistedFeatureFlags()[i].value, file: file, line: line)
        }
    }

    func persistedFeatureFlags() -> [FeatureFlag] {
        return mockedPersister.invokedFeatureFlags!
    }
}
