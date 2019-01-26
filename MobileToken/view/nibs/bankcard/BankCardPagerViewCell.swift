
import UIKit
import FSPagerView

class BankCardPagerViewCell: FSPagerViewCell {

    @IBOutlet weak var vCard: CardCellXibView!
    @IBOutlet var viewBankCard: UIView!
    @IBOutlet var viewFirstOtp: UIView!
    @IBOutlet var viewSecondOtp: UIView!
    
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
        let viewFirstRow = AddPasswordViewDesignable()
        let vFirstRow = viewFirstRow.loadViewFromNib()
        vFirstRow?.frame.size = viewFirstOtp.frame.size
        viewFirstOtp.addSubview(vFirstRow!)
        let viewSecondRpw = AddPasswordViewDesignable()
        let vSecondRow = viewSecondRpw.loadViewFromNib()
        vSecondRow?.frame.size = viewSecondOtp.frame.size
        viewSecondOtp.addSubview(vSecondRow!)
    }
    
    @objc func buttonAction() {
        vCard.cardCellXibProtocol?.actionSheetButtonClicked()
    }
    
    func setCardName(cardName:String) {
        vCard.labelCardName.text = cardName
    }
    
    func setBank(card: Card) {
        for token in card.TokenList {
            switch token.cryptoModuleId {
                case Token.CryptoModuleId.one?:
                    viewFirstOtp.subviews.forEach{ view in
                        view.removeFromSuperview()
                    }
                case Token.CryptoModuleId.two?:
                    break
                default: break
            }
            
        }
    }
    
    func addOtpLayout(token: Token) {
        
    }
}
