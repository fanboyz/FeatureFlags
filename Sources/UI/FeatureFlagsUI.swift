//
//  FeatureFlagsUI.swift
//
//  Copyright © 2016 Rise Project. All rights reserved.
//

import Foundation
import UIKit

public class FeatureFlagsUI {

    public static func launch(sharedFeatureFlagFile file: NSURL) -> UIViewController {
        let viewController = FeatureFlagsViewController()
        viewController.featureFlagsMutator = FeatureFlagsMutator(sharedFeatureFlagFile: file)
        return viewController
    }
}
