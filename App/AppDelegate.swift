//
//  AppDelegate.swift
//  App
//
//  Created by Sean Henry RP on 18/08/2016.
//  Copyright © 2016 Rise Project. All rights reserved.
//

import UIKit
import FeatureFlags

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let file = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.riseproject.featureflags")!
        .URLByAppendingPathComponent("featureFlags.plist")
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let flagsController = FeatureFlagsUI.launch(sharedFeatureFlagFile: file!)
        window?.rootViewController = UINavigationController(rootViewController: flagsController)
        window?.makeKeyAndVisible()
        return true
    }
}
