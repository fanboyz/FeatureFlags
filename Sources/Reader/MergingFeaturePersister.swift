
import Foundation

class MergingFeaturePersister {
    
    private let fetcher: FeatureFlagFetcher
    private let persister: FeatureFlagPersister
    
    init(fetcher: FeatureFlagFetcher, persister: FeatureFlagPersister) {
        self.fetcher = fetcher
        self.persister = persister
    }
    
    func persist(_ features: [Feature]) {
        persister.persist(features.map(toFeatureFlag))
    }
    
    private func toFeatureFlag(_ feature: Feature) -> FeatureFlag {
        let oldFeatures = fetcher.fetch()
        var value = false
        if let result = oldFeatures.findFirst(matching(feature)) {
            value = result.value
        }
        return FeatureFlag(key: feature.key, name: feature.name, value: value)
    }
    
    private func matching(_ feature: Feature) -> (FeatureFlag) -> Bool {
        return { featureFlag in
            feature.key == featureFlag.key
        }
    }
}

extension Array {
    
    fileprivate func findFirst(_ matching: (Element) -> Bool) -> Element? {
        if let index = index(where: matching) {
            return self[index]
        }
        return nil
    }
}
