import UIKit

class LockScreenTimeSettingTableViewCell: UITableViewCell {
    
    @IBOutlet var viewCell: UIView!
    @IBOutlet var viewButtons: UIView!
    @IBOutlet var collectionButtonsTime: [UIButton]!
    @IBOutlet var labelSecond: UILabel!
    
    var selectedIndex:Int?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        viewButtons.layer.cornerRadius = 5
        for index in collectionButtonsTime.indices {
            
            let button  = collectionButtonsTime[index]
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.setTitleColor(R.color.primaryDark(), for: .selected)
            button.setTitleColor(R.color.buttonColor(), for: .normal)
            button.tintColor = .clear
            
            if index == selectedIndex {
                setSelected(button: button)
            }
            else {
                setDeselect(button: button)
            }
        }
    }
    
    func setSelectedIndex(selectedIndex:Int) {
        self.selectedIndex = selectedIndex
        setSelected(button: collectionButtonsTime[selectedIndex])
    }
    
    private func setSelected(button:UIButton){
        labelSecond.text =  button.currentTitle! + " " + R.string.localizable.lb_seconds()
        button.layer.backgroundColor = R.color.buttonColor()?.cgColor
        button.isSelected = true
        
    }
    
    private func setDeselect(button:UIButton){
        button.layer.borderColor = R.color.buttonColor()?.cgColor
        button.backgroundColor = R.color.primaryDark()
        button.isSelected = false
        
    }
    
    @IBAction func onTimeButton(_ sender: UIButton) {
        
        for index in collectionButtonsTime.indices {
            let button  = collectionButtonsTime[index]
            if index == collectionButtonsTime.index(of: sender)
            {
                selectedIndex = index
                setSelected(button: button)
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
