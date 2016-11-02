
import Foundation

class MergingFeaturePersister {
    
    private let fetcher: FeatureFlagFetcher
    private let persister: FeatureFlagPersister
    
    init(fetcher: FeatureFlagFetcher, persister: FeatureFlagPersister) {
        self.fetcher = fetcher
        self.persister = persister
    }
    
    func persist(_ features: [Feature]) {
        let flags = fetcher.fetch()
        persister.persist(features.map(mergingFeatureFlag(with: flags)))
    }
    
    private func mergingFeatureFlag(with flags: [FeatureFlag]) -> (Feature) -> FeatureFlag {
        return { [unowned self] feature in
            var value = false
            if let result = flags.first(where: self.matching(feature)) {
                value = result.value
            }
            return FeatureFlag(key: feature.key, name: feature.name, value: value)
        }
    }
    
    private func matching(_ feature: Feature) -> (FeatureFlag) -> Bool {
        return { featureFlag in
            feature.key == featureFlag.key
        }
    }
}
