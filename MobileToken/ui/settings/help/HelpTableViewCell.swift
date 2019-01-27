import UIKit

class HelpTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.numberOfLines = 0
        self.textLabel?.textAlignment = .right
        self.textLabel?.font = R.font.iranSansMobile(size: 16)
        self.textLabel?.textColor = R.color.buttonColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}
