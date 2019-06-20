import UIKit

class HelpTableViewCell: UITableViewCell {
    @IBOutlet var labelQuestion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        labelQuestion.font = UIHelper.getFont(size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}
