
import Foundation

protocol FeatureFlagPersister {
    func persist(_ featureFlags: [FeatureFlag])
}
