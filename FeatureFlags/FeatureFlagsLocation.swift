//
//  FeatureFlagsLocation.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation

public class FeatureFlagsLocation {

    public class var defaultLocation: NSURL? {
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.riseproject.featureflags")?.URLByAppendingPathComponent("featureFlags.plist")
    }
}
