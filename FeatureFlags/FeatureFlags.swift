//
//  FeatureFlags.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public protocol FeatureFlagsDelegate: class {
    var sharedFeatureFlagFile: NSURL { get }
    var features: [Feature] { get }
}

public class FeatureFlags {
    
    private let flagFetcher: FlagValueFetcher
    
    public init(delegate: FeatureFlagsDelegate) {
        let sharedFile = delegate.sharedFeatureFlagFile
        let fetcher = PlistFeatureFlagFetcher(file: sharedFile)
        let persister = PlistFeatureFlagPersister(file: sharedFile)
        let merger = MergingFeaturePersister(fetcher: fetcher, persister: persister)
        flagFetcher = FlagValueFetcher(fetcher: fetcher)
        merger.persist(delegate.features)
    }
    
    public func value(forFlag flag: String) -> Bool {
        return flagFetcher.fetchValue(forFlag: flag) ?? false
    }
}
