
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
                    iniOtp(token: token)
                }
                
            }
        } else {
            // mask card
        }
            
    }
    
    func iniOtp(token: Token) {
        let view = getOtpView()
        initOtpView(token: token, view: view)
        view.lbOtp.text = generateOtp(token: token)
        //    initProgressbar(progressBar, token);
    }
    
    
    func initOtpView(token: Token, view: OtpViewDesignable) {
        if token.cryptoModuleId == Token.CryptoModuleId.one {
            viewFirstOtp.subviews.forEach { view in
                view.removeFromSuperview()
            }
            view.lbPassword.text = R.string.localizable.everywhere_firstpassword()
            viewFirstOtp.addSubview(view)
                
        } else if  token.cryptoModuleId == Token.CryptoModuleId.two{
            viewFirstOtp.subviews.forEach { view in
                view.removeFromSuperview()
            }
            view.lbPassword.text = R.string.localizable.everywhere_secondpassword()
            viewSecondOtp.addSubview(view)
        }
    }
    
   
    func getOtpView() -> OtpViewDesignable {
        let otpView = OtpViewDesignable()
        otpView.frame.size =  CGSize(width: viewFirstOtp.layer.frame.width-20, height: 40)
        return otpView
    }
    
    func generateOtp(token: Token) -> String{
        var otp = token.generateTotp()
        otp = otp.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return otp
    }
    
    func initProgressBar(view: OtpViewDesignable, token: Token) {
        let calendar = Calendar.current
        let time=calendar.dateComponents([.hour,.minute,.second], from: Date())
        let second = Float(time.second!)
        view.vProgress.progress = (Float(second) - token.timeInterval!) / 60
        let diff = token.timeInterval! - second
        let timer: Timer!
//        timer = Timer.scheduledTimer(timeInterval: <#T##TimeInterval#>, target: <#T##Any#>, selector: <#T##Selector#>, userInfo: <#T##Any?#>, repeats: <#T##Bool#>)
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
