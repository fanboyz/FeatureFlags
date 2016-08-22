//
//  FeatureFlagFetcher.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

protocol FeatureFlagFetcher {
    func fetch() -> [FeatureFlag]
}
