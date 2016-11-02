
import Foundation

public class FeatureFlagsWriter {

    let fetcher: FeatureFlagFetcher
    let persister: FeatureFlagPersister

    public convenience init(sharedFeatureFlagFile: URL) {
        self.init(
            fetcher: PlistFeatureFlagFetcher(file: sharedFeatureFlagFile),
            persister: PlistFeatureFlagPersister(file: sharedFeatureFlagFile)
        )
    }

    init(fetcher: FeatureFlagFetcher, persister: FeatureFlagPersister) {
        self.fetcher = fetcher
        self.persister = persister
    }

    public func update(key: String, to value: Bool) {
        let flags = fetch().map(changing(key, to: value))
        persister.persist(flags)
    }

    func fetch() -> [FeatureFlag] {
        return fetcher.fetch()
    }

    private func changing(_ key: String, to value: Bool) -> (FeatureFlag) -> (FeatureFlag) {
        return { flag in
            var flag = flag
            if flag.key == key {
                flag.value = value
            }
            return flag
        }
    }

    private func persist(_ featureFlags: [FeatureFlag]) {
        persister.persist(featureFlags)
    }
}
