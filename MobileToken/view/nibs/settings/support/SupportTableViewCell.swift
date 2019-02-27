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
        self.imageLogo.layer.backgroundColor = R.color.primaryLight()?.cgColor
        self.imageLogo.tintColor = R.color.primaryLight()
        self.buttonCall.layer.cornerRadius = 5
        
        //viewAddCard.layer.cornerRadius = 10
        self.view.layer.shadowPath = UIBezierPath(roundedRect: self.view.bounds, cornerRadius: 10).cgPath
        self.view.layer.shadowRadius = 3
        self.view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.view.layer.shadowOpacity = 0.2
        self.view.layer.shadowColor = R.color.primary()?.withAlphaComponent(0.15).cgColor
        self.view.layer.borderWidth = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func onButtonCall(_ sender: UIButton) {
        if let phone = labelPhoneNumber.text {
        UIApplication.shared.open(URL(string: "tel://\(phone)")!)
        }
    }
    
}
