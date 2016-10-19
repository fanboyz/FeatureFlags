
import Foundation
@testable import FeatureFlags

class MockFeatureFlagPersister: FeatureFlagPersister {
    
    var didPersist = false
    var invokedFeatureFlags: [FeatureFlag]?
    func persist(featureFlags: [FeatureFlag]) {
        didPersist = true
        invokedFeatureFlags = featureFlags
    }
}
