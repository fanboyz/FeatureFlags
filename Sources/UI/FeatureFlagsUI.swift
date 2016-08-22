//
//  FeatureFlagsUI.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public class FeatureFlagsUI {

    let fetcher: FeatureFlagFetcher
    let persister: FeatureFlagPersister

    public convenience init(sharedFeatureFlagFile: NSURL) {
        self.init(
            fetcher: PlistFeatureFlagFetcher(file: sharedFeatureFlagFile),
            persister: PlistFeatureFlagPersister(file: sharedFeatureFlagFile)
        )
    }

    init(fetcher: FeatureFlagFetcher, persister: FeatureFlagPersister) {
        self.fetcher = fetcher
        self.persister = persister
    }

    public func fetch() -> [FeatureFlag] {
        return fetcher.fetch()
    }

    public func persist(featureFlags: [FeatureFlag]) {
        persister.persist(featureFlags)
    }
}
