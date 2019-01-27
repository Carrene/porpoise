
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
        initDefaultView()
    }
    
    func initDefaultView() {
        let viewFirstRow = AddPasswordViewDesignable()
        viewFirstRow.frame.size = CGSize(width: viewFirstOtp.layer.frame.width-20, height: 40)
        viewFirstOtp.addSubview(viewFirstRow)
        
        let viewSecondRpw = AddPasswordViewDesignable()
        viewSecondRpw.frame.size = CGSize(width: viewSecondOtp.layer.frame.width-20, height: 40)
        viewSecondOtp.addSubview(viewSecondRpw)
    }
    
    func set(card: Card) {
        let tokenList = card.TokenList
        if tokenList.count > 0 {
            for token in card.TokenList {
                token.bank = card.bank
                if token.parse() {
                    // mask card
                }
//                switch token.cryptoModuleId {
//                case Token.CryptoModuleId.one?:
//                    viewFirstOtp.subviews.forEach{ view in
//                        view.removeFromSuperview()
//                    }
//                case Token.CryptoModuleId.two?:
//                    break
//                default: break
//                }
                
            }
        } else {
            // mask card
        }
            
    }
    
    func getOtpView() -> OtpViewDesignable {
        let otpView = OtpViewDesignable()
        let vRow = otpView.loadViewFromNib()
        vRow?.frame.size = viewFirstOtp.frame.size
        
        return vRow! as! OtpViewDesignable
    }
    
    func addOtpLayout(token: Token) {
        
    }
    
    @objc func buttonAction() {
        vCard.cardCellXibProtocol?.actionSheetButtonClicked()
    }
    
    func setCardName(cardName:String) {
        vCard.labelCardName.text = cardName
    }
}
