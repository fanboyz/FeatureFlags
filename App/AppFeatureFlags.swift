
import Foundation
import FeatureFlags

class AppFeatureFlags {

    static let instance = AppFeatureFlags()
    let exampleFeature = Feature(key: "example", name: "Example Feature")
    lazy var reader: FeatureFlagsReader = FeatureFlagsReader(delegate: self)

    init() {
        createDirectory()
    }

    var isExampleFeatureOn: Bool {
        return reader.value(forFlag: exampleFeature.key)
    }
}

extension AppFeatureFlags: FeatureFlagsReaderDelegate {

    var sharedFeatureFlagFile: NSURL {
        return AppFeatureFlags.directory
            .URLByAppendingPathComponent("featureFlags.plist")!
    }

    var features: [Feature] {
        return [
            exampleFeature
        ]
    }
}

extension AppFeatureFlags {

    private static var directory: NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    }

    private func createDirectory() {
        let directory = AppFeatureFlags.directory
        _ = try? NSFileManager.defaultManager().createDirectoryAtURL(directory, withIntermediateDirectories: true, attributes: nil)
    }
}
