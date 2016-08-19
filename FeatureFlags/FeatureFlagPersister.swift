//
//  FeaturePersister.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public protocol FeatureFlagPersister {
    func persist(featureFlags: [FeatureFlag])
}
