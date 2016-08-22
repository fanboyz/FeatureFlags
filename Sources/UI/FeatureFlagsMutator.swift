//
//  FeatureFlagsMutator.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation
import UIKit

class FeatureFlagsMutator {

    let fetcher: FeatureFlagFetcher
    let persister: FeatureFlagPersister

    convenience init(sharedFeatureFlagFile: NSURL) {
        self.init(
            fetcher: PlistFeatureFlagFetcher(file: sharedFeatureFlagFile),
            persister: PlistFeatureFlagPersister(file: sharedFeatureFlagFile)
        )
    }

    init(fetcher: FeatureFlagFetcher, persister: FeatureFlagPersister) {
        self.fetcher = fetcher
        self.persister = persister
    }

    func fetch() -> [FeatureFlag] {
        return fetcher.fetch()
    }

    func persist(featureFlags: [FeatureFlag]) {
        persister.persist(featureFlags)
    }
}
