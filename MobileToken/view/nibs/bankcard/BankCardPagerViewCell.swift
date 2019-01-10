
import UIKit
import FSPagerView

class BankCardPagerViewCell: FSPagerViewCell {

    
    @IBOutlet weak var vCard: CardCellXibView!
    @IBOutlet var viewBankCard: UIView!
    @IBOutlet var viewFirstOtp: OtpViewDesignable!
    @IBOutlet var viewSecondOtp: OtpViewDesignable!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vCard.layer.cornerRadius = 10
        vCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        vCard.layer.borderWidth = 0.5
        viewBankCard.layer.cornerRadius = 10
        viewBankCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewBankCard.layer.borderWidth = 0.5
//        viewFirstOtp.layer.cornerRadius = 10
//        viewFirstOtp.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
//        viewFirstOtp.layer.borderWidth = 0.5
//        viewSecondOtp.layer.cornerRadius = 10
//        viewSecondOtp.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
//        viewSecondOtp.layer.borderWidth = 0.5
        
    }
    
    

}
