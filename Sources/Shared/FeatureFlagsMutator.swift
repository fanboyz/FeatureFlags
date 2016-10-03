//
//  FeatureFlagsMutator.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation
import UIKit

public class FeatureFlagsMutator {

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

    public func update(key: String, to value: Bool) {
        let flags = fetch().map(changing(key, to: value))
        persister.persist(flags)
    }

    func fetch() -> [FeatureFlag] {
        return fetcher.fetch()
    }

    private func changing(key: String, to value: Bool) -> (FeatureFlag) -> (FeatureFlag) {
        return { flag in
            var flag = flag
            if flag.key == key {
                flag.value = value
            }
            return flag
        }
    }

    private func persist(featureFlags: [FeatureFlag]) {
        persister.persist(featureFlags)
    }
}
