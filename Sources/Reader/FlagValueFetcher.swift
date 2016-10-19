
import Foundation

class FlagValueFetcher {
    
    private let fetcher: FeatureFlagFetcher
    
    init(fetcher: FeatureFlagFetcher) {
        self.fetcher = fetcher
    }
    
    func fetchValue(forFlag flag: String) -> Bool? {
        let features = fetcher.fetch()
        return features.filter(matching(flag)).first?.value
    }
    
    private func matching(_ flag: String) -> (FeatureFlag) -> Bool {
        return { feature in
            feature.key == flag
        }
    }
}
