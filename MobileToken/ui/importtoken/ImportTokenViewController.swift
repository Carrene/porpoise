import UIKit
import XLActionController

protocol ImportToeknDelegate {
    func importedToken(card: Card)
}

class ImportTokenViewController: BaseViewController,UITextViewDelegate, ImportTokenViewProtocol {
    
    @IBOutlet weak var labelAtmCounter: UILabel!
    @IBOutlet weak var labelSmsCounter: UILabel!
    @IBOutlet weak var btConfirm: UIBarButtonItem!
    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textViewAtmCode: UITextView!
    @IBOutlet var labelAtmCode: UILabel!
    @IBOutlet var textViewSmsCode: UITextView!
    @IBOutlet var labelSmsCode: UILabel!
    
    var card: Card?
    var cryptoModuleId: Token.CryptoModuleId?
    var presenter: ImportTokenPresenterProtokol?
    var importTokenDelegate: ImportToeknDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ImportTokenPresenter(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let cardNumberArray = UIHelper.getMaskCardNumber(number: (card?.number!)!) {
            let reversedCardNumber = Array(cardNumberArray.reversed())
            for i in 0 ..< reversedCardNumber.count {
                viewCard.labelCardNumber[i].text = reversedCardNumber[i]
            }
        }
    }
    
    func set(card: Card, cryptoModuleId: Token.CryptoModuleId) {
        self.card = card
        self.cryptoModuleId = cryptoModuleId
    }
    
    func setDelegate(importTokenDelegate: ImportToeknDelegate) {
        self.importTokenDelegate = importTokenDelegate
    }
    
    func initUIComponents() {
        viewCard.buttonActionSheet.isHidden = true
        btConfirm.isEnabled = false
        
        viewCard.layer.cornerRadius = 10
        viewCard.layer.borderWidth = 0
        //viewCard.layer.shadowPath = UIBezierPath(roundedRect: viewCard.bounds, cornerRadius: 10).cgPath
        viewCard.layer.shadowRadius = 5
        viewCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCard.layer.shadowOpacity = 0.5
        viewCard.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        viewCard.layer.borderWidth = 0
        viewCard.buttonActionSheet.isHidden = true
        viewCard.imageShowPassword.isHidden = true
        
        viewCard.labelTokenNumber.isHidden = false
        textViewAtmCode.layer.cornerRadius = 5
        textViewSmsCode.layer.cornerRadius = 5
        if self.cryptoModuleId == Token.CryptoModuleId.one {
            self.viewCard.labelTokenNumber.text = R.string.localizable.everywhere_firstpassword()
        } else {
            self.viewCard.labelTokenNumber.text = R.string.localizable.everywhere_secondpassword()
        }
        textViewAtmCode.delegate = self
        textViewSmsCode.delegate = self
        textViewSmsCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        textViewAtmCode.layer.borderWidth = 2
        textViewAtmCode.layer.borderColor = R.color.buttonColor()!.cgColor
        textViewAtmCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        labelAtmCode.font = R.font.iranSansMobile(size: 12)
        labelSmsCode.font = R.font.iranSansMobile(size: 12)
        labelAtmCounter.font = R.font.iranSansMobile(size: 12)
        labelSmsCounter.font = R.font.iranSansMobile(size: 12)
        textViewSmsCode.layer.borderWidth = 2
        textViewSmsCode.layer.borderColor = R.color.buttonColor()!.cgColor
        self.hideKeyboardWhenTappedAround()
        initBankCard()
    }
    
    func initListeners() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(onTextView(recognizer:)))
        textViewSmsCode.addGestureRecognizer(gesture)
    }
    
    @objc func onTextView(recognizer: UILongPressGestureRecognizer) {
        
        self.view.endEditing(true)
        guard recognizer.state == .recognized else { return }
        
        if let recognizerView = recognizer.view,
            let recognizerSuperView = recognizerView.superview, recognizerView.becomeFirstResponder()
        {
            let menuController = UIMenuController.shared
            menuController.menuItems = [UIMenuItem(title: "P", action: #selector(pasteText(_:)))]
            menuController.setTargetRect(recognizerView.frame, in: recognizerSuperView)
            menuController.setMenuVisible(true, animated:true)
            
        }
        
    }
    
    @objc func pasteText(_ sender: Any?) {
        let text = UIPasteboard.general.string ?? ""
        let resualt = textView(textViewSmsCode, shouldChangeTextIn: NSRange(location: 0, length: 0), replacementText: text)
        if resualt == false, text.count == 120 {
            self.textViewSmsCode.text = text
        } else if textViewSmsCode.text.count != 120{
            SnackBarHelper.init(message: "Text Problem", color: .red, duration: .middle).show()
        }
    }
    
    func initBankCard() {
        viewCard.backgroundColor = R.color.secondaryDark()
        viewCard.imageLogo.image = BankUtil.getLightLogo(bank: (card?.bank)!)
        viewCard.labelCardName.text = card?.cardName
        viewCard.labelBankName.text = BankUtil.getName(bank: card!.bank!)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCounter(textView: textView)
        if textViewAtmCode.text.count == 8 && textViewSmsCode.text.count == 120 {
            btConfirm.isEnabled = true
        } else {
            btConfirm.isEnabled = false
        }
    }
    
    func updateCounter(textView: UITextView) {
        if textView == textViewAtmCode {
            labelAtmCounter.text =  "\(textViewAtmCode.text.count)/8"
        }
        if textView == textViewSmsCode {
            labelSmsCounter.text = "\(textViewSmsCode.text.count)/120"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.contains("کد") {
            textView.text = nil
        }
        textView.layer.borderColor = R.color.secondary()?.cgColor
        textView.textColor = R.color.buttonColor()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = R.color.buttonColor()?.cgColor
        textView.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        if textViewSmsCode.text.isEmpty {
            textView.text = R.string.localizable.ph_sms_code()
        }
        if textViewAtmCode.text.isEmpty {
            textView.text = R.string.localizable.ph_atm_code()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if textView == textViewAtmCode {
            
            return numberOfChars < 9
        }
        else {
            let smsText = text.components(separatedBy: CharacterSet(charactersIn: "\n "))
            smsText.forEach{ splitedText in
                print(splitedText.count)
                if splitedText.count == 120 && smsText.count > 1 {
                    textViewSmsCode.text = String(splitedText)
                    self.updateCounter(textView: textViewSmsCode)
                    if textViewAtmCode.text.count == 8 {
                        btConfirm.isEnabled = true
                    }
                }
            }
            return numberOfChars < 121
        }
    }
    
    func tokenImported(card: Card) {
        self.importTokenDelegate?.importedToken(card:card)
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func onConfirmClicked(_ sender: Any) {
        let sms = textViewSmsCode.text.replacedArabicPersianDigitsWithEnglish
        let atm = textViewAtmCode.text.replacedArabicPersianDigitsWithEnglish
        let tokenPacket = sms + atm
        presenter?.importToken(tokenPacket:  tokenPacket, card: card!, cryptoModuleId: self.cryptoModuleId!)
    }
}
