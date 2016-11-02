
#if os(iOS)

import UIKit

protocol SwitchCellDelegate: class {
    func cell(_ cell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    
    weak var delegate: SwitchCellDelegate?
    @IBOutlet var switchControl: UISwitch!
    @IBOutlet var nameLabel: UILabel!
    
    var name: String? {
        set { nameLabel.text = newValue }
        get { return nameLabel.text }
    }
    
    var value: Bool {
        set { switchControl.isOn = newValue }
        get { return switchControl.isOn }
    }
    
    @IBAction func didChangeSwitch() {
        delegate?.cell(self, didChangeValue: switchControl.isOn)
    }
}


#endif
