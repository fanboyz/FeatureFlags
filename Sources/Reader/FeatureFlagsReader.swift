
import Foundation

public protocol FeatureFlagsReaderDelegate: class {
    var sharedFeatureFlagFile: URL { get }
    var features: [Feature] { get }
}

public class FeatureFlagsReader {
    
    private let flagFetcher: FlagValueFetcher
    
    public init(delegate: FeatureFlagsReaderDelegate) {
        let sharedFile = delegate.sharedFeatureFlagFile
        let fetcher = PlistFeatureFlagFetcher(file: sharedFile)
        let persister = PlistFeatureFlagPersister(file: sharedFile)
        let merger = MergingFeaturePersister(fetcher: fetcher, persister: persister)
        flagFetcher = FlagValueFetcher(fetcher: fetcher)
        merger.persist(delegate.features)
    }
    
    public func value(for feature: Feature) -> Bool {
        return flagFetcher.fetchValue(forKey: feature.key) ?? false
    }
}
