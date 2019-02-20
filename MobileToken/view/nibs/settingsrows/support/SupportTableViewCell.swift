import UIKit

class SupportTableViewCell: UITableViewCell {

    @IBOutlet var imageLogo: UIImageView!
    @IBOutlet var labelBankName: UILabel!
    @IBOutlet var labelPhoneNumber: UILabel!
    @IBOutlet var buttonCall: UIButton!
    @IBOutlet var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cornerRadius = 10
        self.imageLogo.layer.cornerRadius = 5
        self.buttonCall.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func onButtonCall(_ sender: UIButton) {
    }
    
}
