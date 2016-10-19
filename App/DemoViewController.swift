
import UIKit
import FeatureFlags

class DemoViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let isExampleFeatureOn = AppFeatureFlags.instance.isExampleFeatureOn
        label.text = isExampleFeatureOn ? "On" : "Off"
        view.backgroundColor = isExampleFeatureOn ? .blueColor() : .greenColor()
    }
}
