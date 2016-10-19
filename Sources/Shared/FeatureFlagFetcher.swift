
import Foundation

protocol FeatureFlagFetcher {
    func fetch() -> [FeatureFlag]
}
