
import Foundation

class PlistFeatureFlagPersister: FeatureFlagPersister {
    
    private let file: NSURL
    
    init(file: NSURL) {
        self.file = file
    }
    
    func persist(featureFlags: [FeatureFlag]) {
        let array = featureFlags.map(toPlistDictionary) as NSArray
        array.writeToFile(file.path!, atomically: true)
    }
    
    
    private func toPlistDictionary(feature: FeatureFlag) -> [String: AnyObject] {
        return [
            "key": feature.key,
            "name": feature.name,
            "value": feature.value
        ]
    }
}
