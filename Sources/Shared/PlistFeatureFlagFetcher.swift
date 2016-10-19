
import Foundation

class PlistFeatureFlagFetcher: FeatureFlagFetcher {
    
    private let file: NSURL
    
    init(file: NSURL) {
        self.file = file
    }
    
    func fetch() -> [FeatureFlag] {
        guard let array = NSArray(contentsOfURL: file) else { return [] }
        return array.flatMap(toDictionary)
                    .flatMap(toFeatureFlag)
    }
    
    private func toDictionary(object: AnyObject) -> [String: AnyObject]? {
        return object as? [String: AnyObject]
    }
    
    private func toFeatureFlag(dictionary: [String: AnyObject]) -> FeatureFlag? {
        guard let key = dictionary["key"] as? String,
                  name = dictionary["name"] as? String,
                  value = dictionary["value"] as? NSNumber else {
            return nil
        }
        return FeatureFlag(key: key, name: name, value: value.boolValue)
    }
}
