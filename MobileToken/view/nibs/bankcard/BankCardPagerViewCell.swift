
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
        //vCard.buttonActionSheet.on
        let actionButton = vCard.buttonActionSheet
        actionButton!.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        vCard.cardCellXibProtocol?.actionSheetButtonClicked()
    }
    
    func setCardName(cardName:String) {
        vCard.labelCardName.text = cardName
    }
}
