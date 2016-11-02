
import Foundation

class PlistFeatureFlagFetcher: FeatureFlagFetcher {
    
    private let file: URL
    
    init(file: URL) {
        self.file = file
    }
    
    func fetch() -> [FeatureFlag] {
        guard let array = NSArray(contentsOf: file) else { return [] }
        return array.flatMap(toDictionary)
                    .flatMap(toFeatureFlag)
    }
    
    private func toDictionary(_ object: Any) -> [String: Any]? {
        return object as? [String: Any]
    }
    
    private func toFeatureFlag(_ dictionary: [String: Any]) -> FeatureFlag? {
        guard let key = dictionary["key"] as? String,
              let name = dictionary["name"] as? String,
              let value = dictionary["value"] as? NSNumber else {
            return nil
        }
        return FeatureFlag(key: key, name: name, value: value.boolValue)
    }
}
