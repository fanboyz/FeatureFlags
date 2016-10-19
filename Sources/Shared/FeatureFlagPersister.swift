
import Foundation

protocol FeatureFlagPersister {
    func persist(featureFlags: [FeatureFlag])
}
