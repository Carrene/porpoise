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
        
        self.view.layer.shadowRadius = 5
        self.view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.view.layer.shadowOpacity = 0.2
        self.view.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        self.view.layer.borderWidth = 0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func handleTap() {
        if let phone = labelPhoneNumber.text {
            UIApplication.shared.open(URL(string: "tel://\(phone)")!)
        }
    }
    
    @IBAction func onButtonCall(_ sender: UIButton) {
        if let phone = labelPhoneNumber.text {
        UIApplication.shared.open(URL(string: "tel://\(phone)")!)
        }
    }
    
}
