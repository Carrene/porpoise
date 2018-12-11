
import UIKit

class PasswordHintTableViewCell: UITableViewCell {
    @IBOutlet var lbHint: UILabel!
    @IBOutlet var imgCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbHint.font = R.font.iranSansMobile(size: 12)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }
    
}
