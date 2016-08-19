//
//  FlagValueFetcher.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public class FlagValueFetcher {
    
    private let fetcher: FeatureFlagFetcher
    
    public init(fetcher: FeatureFlagFetcher) {
        self.fetcher = fetcher
    }
    
    public func fetchValue(forFlag flag: String) -> Bool? {
        let features = fetcher.fetch()
        return features.filter(matching(flag)).first?.value
    }
    
    private func matching(flag: String) -> FeatureFlag -> Bool {
        return { feature in
            feature.key == flag
        }
    }
}
