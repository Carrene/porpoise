import UIKit

class SupportTableViewCell: UITableViewCell {

    @IBOutlet var imageLogo: UIImageView!
    @IBOutlet var labelBankName: UILabel!
    @IBOutlet var labelPhoneNumber: UILabel!
    @IBOutlet var buttonCall: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func onButtonCall(_ sender: UIButton) {
    }
    
}
