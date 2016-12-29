
import XCTest
@testable import FeatureFlags

class MergingFeaturePersisterTests: XCTestCase {
    
    var persister: MergingFeaturePersister!
    var mockedFetcher: MockFeatureFlagFetcher!
    var mockedPersister: MockFeatureFlagPersister!
    
    override func setUp() {
        super.setUp()
        mockedFetcher = MockFeatureFlagFetcher()
        mockedPersister = MockFeatureFlagPersister()
        persister = MergingFeaturePersister(fetcher: mockedFetcher, persister: mockedPersister)
    }
    
    // MARK: - persist

    func test_persist_shouldPersistFeaturesFlags_whenNoExistingFeatures() {
        persister.persist([feature1()])
        XCTAssertEqual(mockedPersister.invokedFeatureFlags!, [featureFlag1()])
    }

    func test_persist_shouldSetDefaultValue_whenMergingNewFeature() {
        persister.persist([defaultTrueFeature()])
        XCTAssertEqual(mockedPersister.invokedFeatureFlags!, [defaultTrueFeatureFlag()])
    }
    
    func test_persist_shouldNotPersistOldFeatures() {
        mockedFetcher.stubbedFeatureFlags = [featureFlag1()]
        persister.persist([])
        XCTAssert(mockedPersister.invokedFeatureFlags!.isEmpty)
    }
    
    func test_persist_shouldPersistNewFeatures_andPreserveTheirValues() {
        mockedFetcher.stubbedFeatureFlags = [featureFlag1(), trueFeatureFlag()]
        persister.persist([feature1(), trueFeature()])
        XCTAssertEqual(mockedPersister.invokedFeatureFlags!, [featureFlag1(), trueFeatureFlag()])
    }
    
    // MARK: - Helpers
    
    func feature1() -> Feature {
        return Feature(key: "feature1", name: "feature1")
    }
    
    func feature2() -> Feature {
        return Feature(key: "feature2", name: "feature2")
    }
    
    func trueFeature() -> Feature {
        return Feature(key: "true", name: "true")
    }

    func defaultTrueFeature() -> Feature {
        return Feature(key: "defaultTrue", name: "defaultTrue", defaultValue: true)
    }
    
    func featureFlag1() -> FeatureFlag {
        return FeatureFlag(key: "feature1", name: "feature1", value: false)
    }
    
    func featureFlag2() -> FeatureFlag {
        return FeatureFlag(key: "feature2", name: "feature2", value: false)
    }
    
    func trueFeatureFlag() -> FeatureFlag {
        return FeatureFlag(key: "true", name: "true", value: true)
    }

    func defaultTrueFeatureFlag() -> FeatureFlag {
        return FeatureFlag(key: "defaultTrue", name: "defaultTrue", value: true)
    }
}
