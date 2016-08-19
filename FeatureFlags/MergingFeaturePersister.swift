//
//  MergingFeaturePersister.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public class MergingFeaturePersister {
    
    private let fetcher: FeatureFlagFetcher
    private let persister: FeatureFlagPersister
    
    public init(fetcher: FeatureFlagFetcher, persister: FeatureFlagPersister) {
        self.fetcher = fetcher
        self.persister = persister
    }
    
    public func persist(features: [Feature]) {
        persister.persist(features.map(toFeatureFlag))
    }
    
    private func toFeatureFlag(feature: Feature) -> FeatureFlag {
        let oldFeatures = fetcher.fetch()
        var value = false
        if let result = oldFeatures.findFirst(matching(feature)) {
            value = result.value
        }
        return FeatureFlag(key: feature.key, name: feature.name, value: value)
    }
    
    private func matching(feature: Feature) -> FeatureFlag -> Bool {
        return { featureFlag in
            feature.key == featureFlag.key
        }
    }
}

extension Array {
    
    private func findFirst(@noescape matching: (Element) -> Bool) -> Element? {
        if let index = indexOf(matching) {
            return self[index]
        }
        return nil
    }
}
