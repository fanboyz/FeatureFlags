
import UIKit

protocol SwitchCellDelegate: class {
    func cell(cell: SwitchCell, didChangeValue value: Bool)
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
        set { switchControl.on = newValue }
        get { return switchControl.on }
    }
    
    @IBAction func didChangeSwitch() {
        delegate?.cell(self, didChangeValue: switchControl.on)
    }
}
