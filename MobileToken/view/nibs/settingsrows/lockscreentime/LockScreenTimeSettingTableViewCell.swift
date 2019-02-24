import UIKit

protocol LockScreenTimeSettingTableViewCellProtocol {
    func updateLockTimer(lockTimer:Int)
}

class LockScreenTimeSettingTableViewCell: UITableViewCell {
    
    @IBOutlet var viewCell: UIView!
    @IBOutlet var viewButtons: UIView!
    @IBOutlet var collectionButtonsTime: [UIButton]!
    @IBOutlet var labelSecond: UILabel!
    var sender:SettingsTableViewAdapter?
    
    var lockScreenTimeProtocol:LockScreenTimeSettingTableViewCellProtocol?
    var selectedIndex:Int?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        viewButtons.layer.shadowPath = UIBezierPath(roundedRect: viewButtons.bounds, cornerRadius: 5).cgPath
        viewButtons.layer.shadowRadius = 3
        viewButtons.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewButtons.layer.shadowOpacity = 0.2
        viewButtons.layer.backgroundColor = R.color.primaryLight()?.cgColor
        viewButtons.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        viewButtons.layer.cornerRadius = 5
        
        for index in collectionButtonsTime.indices {
            
            let button  = collectionButtonsTime[index]
            button.layer.cornerRadius = 10
            button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: 10).cgPath
            button.layer.shadowRadius = 3
            button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            button.layer.shadowOpacity = 0.2
            button.layer.backgroundColor = R.color.primaryLight()?.cgColor
            button.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
            button.layer.borderWidth = 2
            button.setTitleColor(R.color.buttonColor(), for: .selected)
            button.setTitleColor(R.color.secondary(), for: .normal)
            button.tintColor = .clear
            
            if index == selectedIndex {
                setSelected(button: button)
            }
            else {
                setDeselect(button: button)
            }
        }
    }
    
    func setDelegate(lockScreenTimeProtocol:LockScreenTimeSettingTableViewCellProtocol) {
        self.lockScreenTimeProtocol = lockScreenTimeProtocol
    }
    
    func setSelectedIndex(selectedIndex:Int) {
        self.selectedIndex = selectedIndex
        setSelected(button: collectionButtonsTime[selectedIndex])
    }
    
    private func setSelected(button:UIButton){
        labelSecond.text =  button.currentTitle! + " " + R.string.localizable.lb_seconds()
        button.isSelected = true
        button.layer.borderColor = R.color.secondary()?.cgColor
        
    }
    
    private func setDeselect(button:UIButton){
        button.layer.borderColor = R.color.primaryLight()?.cgColor
        button.isSelected = false
        
    }
    
    @IBAction func onTimeButton(_ sender: UIButton) {
        
        for index in collectionButtonsTime.indices {
            let button  = collectionButtonsTime[index]
            if index == collectionButtonsTime.index(of: sender)
            {
                selectedIndex = index
                setSelected(button: button)
                lockScreenTimeProtocol?.updateLockTimer(lockTimer: Int(button.currentTitle!)!)
            }
            else {
                setDeselect(button: button)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
}
