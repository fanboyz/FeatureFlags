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

    func update(featureFlag: FeatureFlag, to value: Bool) {
        let flags = fetch().map(changing(featureFlag, to: value))
        persister.persist(flags)
    }

    private func changing(featureFlag: FeatureFlag, to value: Bool) -> (FeatureFlag) -> (FeatureFlag) {
        return { flag in
            var flag = flag
            if flag.key == featureFlag.key {
                flag.value = value
            }
            return flag
        }
    }
}
