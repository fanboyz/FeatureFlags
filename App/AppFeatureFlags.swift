
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
        return reader.value(for: exampleFeature)
    }
}

extension AppFeatureFlags: FeatureFlagsReaderDelegate {

    var sharedFeatureFlagFile: URL {
        return AppFeatureFlags.directory
            .appendingPathComponent("featureFlags.plist")
    }

    var features: [Feature] {
        return [
            exampleFeature
        ]
    }
}

extension AppFeatureFlags {

    fileprivate static var directory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    fileprivate func createDirectory() {
        let directory = AppFeatureFlags.directory
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
    }
}
