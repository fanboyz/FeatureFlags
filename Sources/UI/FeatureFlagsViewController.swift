
#if os(iOS)

import UIKit

class FeatureFlagsViewController: UITableViewController {

    var featureFlagsWriter: FeatureFlagsWriter!
    fileprivate var featureFlags = [FeatureFlag]() {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard featureFlagsWriter != nil else {
            showMissingDependencyError()
            return
        }
        title = "Feature Flags"
        setUpTableView()
        setUpBackgroundNotification()
        load()
    }

    private func setUpTableView() {
        let switchCellNib = UINib(nibName: "SwitchCell", bundle: Bundle(for: FeatureFlagsViewController.self))
        tableView.register(switchCellNib, forCellReuseIdentifier: "switchCell")
    }
    
    private func setUpBackgroundNotification() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
            self.load()
        }
    }
    
    private func load() {
        featureFlags = featureFlagsWriter.fetch()
    }
    
    fileprivate func change(value: Bool, atIndex index: Int) {
        featureFlagsWriter.update(key: featureFlags[index].key, to: value)
    }
    
    private func showMissingDependencyError() {
        let alert = UIAlertController(title: "Error", message: "Missing FeatureFlagsWriter dependency", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension FeatureFlagsViewController { // UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureFlags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchCell
        let index = indexPath.row
        cell.name = featureFlags[index].name
        cell.value = featureFlags[index].value
        cell.delegate = self
        return cell
    }
}

extension FeatureFlagsViewController: SwitchCellDelegate {
    
    func cell(_ cell: SwitchCell, didChangeValue value: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        change(value: value, atIndex: indexPath.row)
    }
}

#endif
