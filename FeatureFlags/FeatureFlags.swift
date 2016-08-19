//
//  FeatureFlags.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public protocol FeatureFlagsDataStore: class {
    var features: [Feature] { get }
}

public class FeatureFlagsLauncher {
    
    private let flagFetcher: FlagValueFetcher
    
    public init(dataStore: FeatureFlagsDataStore) {
        let sharedFile = FeatureFlagsLocation.defaultLocation!
        let fetcher = PlistFeatureFlagFetcher(file: sharedFile)
        let persister = PlistFeatureFlagPersister(file: sharedFile)
        let merger = MergingFeaturePersister(fetcher: fetcher, persister: persister)
        flagFetcher = FlagValueFetcher(fetcher: fetcher)
        merger.persist(dataStore.features)
    }
    
    public func value(forFlag flag: String) -> Bool {
        return flagFetcher.fetchValue(forFlag: flag) ?? false
    }
}
