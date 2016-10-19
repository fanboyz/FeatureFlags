
import UIKit
import FeatureFlags

class DemoViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isExampleFeatureOn = AppFeatureFlags.instance.isExampleFeatureOn
        label.text = isExampleFeatureOn ? "On" : "Off"
        view.backgroundColor = isExampleFeatureOn ? .blue : .green
    }
}
