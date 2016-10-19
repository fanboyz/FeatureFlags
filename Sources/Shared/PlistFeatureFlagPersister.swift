
import Foundation

class PlistFeatureFlagPersister: FeatureFlagPersister {
    
    private let file: URL
    
    init(file: URL) {
        self.file = file
    }
    
    func persist(_ featureFlags: [FeatureFlag]) {
        let array = featureFlags.map(toPlistDictionary) as NSArray
        array.write(toFile: file.path, atomically: true)
    }
    
    
    private func toPlistDictionary(_ feature: FeatureFlag) -> [String: Any] {
        return [
            "key": feature.key,
            "name": feature.name,
            "value": feature.value
        ]
    }
}
