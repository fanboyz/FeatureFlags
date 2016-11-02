
import Foundation

class FlagValueFetcher {
    
    private let fetcher: FeatureFlagFetcher
    
    init(fetcher: FeatureFlagFetcher) {
        self.fetcher = fetcher
    }
    
    func fetchValue(forKey key: String) -> Bool? {
        let features = fetcher.fetch()
        return features.filter(matching(key)).first?.value
    }
    
    private func matching(_ key: String) -> (FeatureFlag) -> Bool {
        return { feature in
            feature.key == key
        }
    }
}
