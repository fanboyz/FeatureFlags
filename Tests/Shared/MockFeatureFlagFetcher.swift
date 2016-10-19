
import Foundation
@testable import FeatureFlags

class MockFeatureFlagFetcher: FeatureFlagFetcher {
    
    var didFetch = false
    var stubbedFeatureFlags = [FeatureFlag]()
    func fetch() -> [FeatureFlag] {
        didFetch = true
        return stubbedFeatureFlags
    }
}
