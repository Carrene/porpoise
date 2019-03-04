
import UIKit
import FSPagerView

protocol BankCardPagerViewDelegate {
    func importToken(card: Card, cryptoModuleId: Token.CryptoModuleId)
    func actionSheetButtonClicked(card: Card)
    func saveTimerInstance(timer: Timer)
    func removeTimerInstance(timer: Timer)
}

class BankCardPagerViewCell: FSPagerViewCell {
    
    @IBOutlet weak var vCard: CardCellXibView!
    @IBOutlet var viewBankCard: UIView!
    @IBOutlet var viewFirstOtp: UIView!
    @IBOutlet var viewSecondOtp: UIView!
    var card: Card?
    var bankCardPagerViewDelegate: BankCardPagerViewDelegate?
    var timerFirst: Timer?
    var timerSecond: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        if timerFirst != nil && token.cryptoModuleId == Token.CryptoModuleId.one {
//            timerFirst?.invalidate()
//        }
//
//        if timerSecond != nil && token.cryptoModuleId == Token.CryptoModuleId.two {
//            timerSecond?.invalidate()
//        }
        
        viewBankCard.layer.cornerRadius = 10
        //viewBankCard.layer.shadowPath = UIBezierPath(roundedRect: viewBankCard.bounds, cornerRadius: 10).cgPath
        viewBankCard.layer.shadowRadius = 5
        viewBankCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBankCard.layer.shadowOpacity = 0.1
        viewBankCard.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.15).cgColor
        viewBankCard.layer.borderWidth = 0
        
        vCard.layer.cornerRadius = 10
        vCard.layer.shadowPath = UIBezierPath(roundedRect: vCard.bounds, cornerRadius: 10).cgPath
        vCard.layer.shadowRadius = 5
        vCard.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        vCard.layer.shadowOpacity = 0.2
        vCard.layer.backgroundColor = R.color.primaryLight()?.cgColor
        vCard.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        vCard.labelTokenNumber.isHidden = true
        
        viewBankCard.layer.borderWidth = 0
        let actionButton = vCard.buttonActionSheet
        actionButton!.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func initDefaultView() {
        viewFirstOtp.subviews.forEach { view in
            view.removeFromSuperview()
        }
        viewSecondOtp.subviews.forEach { view in
            view.removeFromSuperview()
        }
        let viewFirstRow = AddPasswordViewDesignable()
        viewFirstRow.labelAddOtp.text = R.string.localizable.lb_add_first_otp()
        viewFirstRow.frame.size = CGSize(width: viewFirstOtp.layer.frame.width, height: 40)
        let tapImportFirstPass = ImportTokenTapGesture(target: self, action: #selector(BankCardPagerViewCell.addOtp(sender:)))
        tapImportFirstPass.cryptoModuleId = Token.CryptoModuleId.one
        viewFirstRow.addGestureRecognizer(tapImportFirstPass)
        viewFirstOtp.addSubview(viewFirstRow)
        
        let viewSecondRow = AddPasswordViewDesignable()
        viewSecondRow.labelAddOtp.text = R.string.localizable.lb_add_second_otp()
        viewSecondRow.frame.size = CGSize(width: viewSecondOtp.layer.frame.width, height: 40)
        
        let tapImportSecondPass = ImportTokenTapGesture(target: self, action: #selector(BankCardPagerViewCell.addOtp(sender:)))
        tapImportSecondPass.cryptoModuleId = Token.CryptoModuleId.two
        viewSecondRow.addGestureRecognizer(tapImportSecondPass)
        viewSecondOtp.addSubview(viewSecondRow)
    }
    
    func set(card: Card) {
        self.vCard.imageLogo.image = BankUtil.getLogo(bank: card.bank!)
        
        if timerFirst != nil {
            timerFirst?.invalidate()
            self.bankCardPagerViewDelegate?.removeTimerInstance(timer: timerFirst!)
            
        }
        
        if timerSecond != nil {
            timerSecond?.invalidate()
            self.bankCardPagerViewDelegate?.removeTimerInstance(timer: timerSecond!)
        }
        
        self.card = card
        
        if let cardNumber = UIHelper.getMaskCardNumber(number: card.number!){
            let reversCards = Array(cardNumber.reversed())
            for i in 0 ..< reversCards.count {
                vCard.labelCardNumber[i].text = reversCards[i]
            }
        }
        
        let tokenList = card.TokenList
        if tokenList.count > 0 {
            for token in card.TokenList {
                token.bank = card.bank
                if token.parse() {
//                    if let cardNumber = UIHelper.getMaskCardNumber(number: card.number!){
//                        let reversCards = Array(cardNumber.reversed())
//                        for i in 0 ..< reversCards.count {
//                            vCard.labelCardNumber[i].text = reversCards[i]
//                        }
//                    }
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
        otp = otp.separate()
        return otp
    }
    
    func initProgressBar(view: OtpViewDesignable, token: Token) {
        let calendar = Calendar.current
        let time=calendar.dateComponents([.hour,.minute,.second], from: Date())
        let second = Float(time.second!)
        let currentProgress = Float(second).truncatingRemainder(dividingBy: (token.timeInterval!)) / token.timeInterval!
        view.vProgress.progress = currentProgress
        view.vProgress.progressTintColor = R.color.primary()
        view.vComponent.backgroundColor = R.color.secondaryDark()
        let diff = token.timeInterval! - currentProgress
        
        if token.cryptoModuleId == Token.CryptoModuleId.one {
            timerFirst = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(BankCardPagerViewCell.timerHandler(timer:))), userInfo: (token: token,view: view, countdownTime: diff), repeats: true)
            self.bankCardPagerViewDelegate?.saveTimerInstance(timer: timerFirst!)
        } else if token.cryptoModuleId == Token.CryptoModuleId.two {
            timerSecond = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(BankCardPagerViewCell.timerHandler(timer:))), userInfo: (token: token,view: view, countdownTime: diff), repeats: true)
            self.bankCardPagerViewDelegate?.saveTimerInstance(timer: timerSecond!)
        }
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
//        vCard.cardCellXibProtocol?.actionSheetButtonClicked()
        bankCardPagerViewDelegate?.actionSheetButtonClicked(card: self.card!)
    }
    
    func setCardName(cardName:String) {
        vCard.labelCardName.text = cardName
    }
    
    override func prepareForReuse() {
       
    }
}
