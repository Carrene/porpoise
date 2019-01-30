
import UIKit
import FSPagerView

protocol BankCardPagerViewDelegate {
    func importToken(card: Card, cryptoModuleId: Token.CryptoModuleId)
}

class BankCardPagerViewCell: FSPagerViewCell {
    
    @IBOutlet weak var vCard: CardCellXibView!
    @IBOutlet var viewBankCard: UIView!
    @IBOutlet var viewFirstOtp: UIView!
    @IBOutlet var viewSecondOtp: UIView!
    var card: Card?
    var bankCardPagerViewDelegate: BankCardPagerViewDelegate?
    
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
        viewFirstRow.frame.size = CGSize(width: viewFirstOtp.layer.frame.width, height: 40)
        let tapImportFirstPass = ImportTokenTapGesture(target: self, action: #selector(BankCardPagerViewCell.addOtp(sender:)))
        tapImportFirstPass.cryptoModuleId = Token.CryptoModuleId.one
        viewFirstRow.addGestureRecognizer(tapImportFirstPass)
        viewFirstOtp.addSubview(viewFirstRow)
        
        let viewSecondRow = AddPasswordViewDesignable()
        viewSecondRow.frame.size = CGSize(width: viewSecondOtp.layer.frame.width, height: 40)
        
        let tapImportSecondPass = ImportTokenTapGesture(target: self, action: #selector(BankCardPagerViewCell.addOtp(sender:)))
        tapImportSecondPass.cryptoModuleId = Token.CryptoModuleId.two
        viewSecondRow.addGestureRecognizer(tapImportSecondPass)
        viewSecondOtp.addSubview(viewSecondRow)
    }
    
    func set(card: Card) {
        self.card = card
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
        initProgressBar(view: view, token: token)
    }
    
    
    func initOtpView(token: Token, view: OtpViewDesignable) {
        if token.cryptoModuleId == Token.CryptoModuleId.one {
            viewFirstOtp.subviews.forEach { view in
                view.removeFromSuperview()
            }
            view.lbPassword.text = R.string.localizable.everywhere_firstpassword()
            viewFirstOtp.addSubview(view)
                
        } else if  token.cryptoModuleId == Token.CryptoModuleId.two{
            viewSecondOtp.subviews.forEach { view in
                view.removeFromSuperview()
            }
            view.lbPassword.text = R.string.localizable.everywhere_secondpassword()
            viewSecondOtp.addSubview(view)
        }
    }
    
   
    func getOtpView() -> OtpViewDesignable {
        let otpView = OtpViewDesignable()
        otpView.frame.size =  CGSize(width: viewFirstOtp.layer.frame.width, height: 40)
        return otpView
    }
    
    func generateOtp(token: Token) -> String{
        var otp = token.generateTotp()
        otp = otp.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print(otp)
        return otp
    }
    
    func initProgressBar(view: OtpViewDesignable, token: Token) {
        let calendar = Calendar.current
        let time=calendar.dateComponents([.hour,.minute,.second], from: Date())
        let second = Float(time.second!)
//        view.vProgress.progress = (Float(second) % (token.timeInterval!)) / token.timeInterval!
        let currentProgress = Float(second).truncatingRemainder(dividingBy: (token.timeInterval!)) / token.timeInterval!
        view.vProgress.progress = currentProgress
        let diff = token.timeInterval! - currentProgress
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: (#selector(BankCardPagerViewCell.timerHandler(timer:))), userInfo: (token: token,view: view, countdownTime: diff), repeats: true)
    }
    
    @objc func timerHandler(timer: Timer) {
        let info = timer.userInfo as! (token: Token,view: OtpViewDesignable, countdownTime: Float)
        let view = info.view
        let token = info.token
        let diff = info.countdownTime
        
        view.vProgress.progress =   view.vProgress.progress + (1/token.timeInterval!)
        if view.vProgress.progress >= 1 {
            timer.invalidate()
            view.vProgress.progress = 0
            iniOtp(token: token)
        }
    }
    
    
    @objc func addOtp(sender: ImportTokenTapGesture) {
        self.bankCardPagerViewDelegate?.importToken(card: self.card!, cryptoModuleId: sender.cryptoModuleId!)
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
