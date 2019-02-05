import UIKit
import XLActionController

class ImportTokenViewController: BaseViewController,UITextViewDelegate,CardCellXibProtocol, ImportTokenViewProtocol {
   
    @IBOutlet weak var btConfirm: UIBarButtonItem!
    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textViewAtmCode: UITextView!
    @IBOutlet var labelAtmCode: UILabel!
    @IBOutlet var textViewSmsCode: UITextView!
    @IBOutlet var labelSmsCode: UILabel!
    @IBOutlet var buttonAddCode: UIButton!
    var card: Card?
    var cryptoModuleId: Token.CryptoModuleId?
    var presenter: ImportTokenPresenterProtokol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCard.setDelegate(cardCellXibProtocol: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter = ImportTokenPresenter(view: self)
    }
    
    func set(card: Card, cryptoModuleId: Token.CryptoModuleId) {
        self.card = card
        self.cryptoModuleId = cryptoModuleId
    }
    
    func initUIComponents() {
        btConfirm.isEnabled = false
        buttonAddCode.layer.cornerRadius = 10
        self.buttonAddCode.backgroundColor = R.color.borderColor()
        viewCard.layer.cornerRadius = 10
        viewCard.contentView.backgroundColor = R.color.primary()
        viewCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewCard.layer.borderWidth = 1
        viewCard.imagePlus.isHidden = true
        viewCard.buttonActionSheet.isEnabled = false
        
        textViewAtmCode.layer.cornerRadius = 10
        textViewSmsCode.layer.cornerRadius = 10
        if self.cryptoModuleId == Token.CryptoModuleId.one {
            self.viewCard.labelBottomTitle.text = R.string.localizable.everywhere_firstpassword()
        } else {
            self.viewCard.labelBottomTitle.text = R.string.localizable.everywhere_secondpassword()
        }
        textViewAtmCode.delegate = self
        textViewSmsCode.delegate = self
        textViewSmsCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        textViewAtmCode.layer.borderWidth = 1
        textViewAtmCode.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        textViewAtmCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        labelAtmCode.font = R.font.iranSansMobile(size: 12)
        labelSmsCode.font = R.font.iranSansMobile(size: 12)
        textViewSmsCode.layer.borderWidth = 1
        textViewSmsCode.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        self.hideKeyboardWhenTappedAround()
        initBankCard()
    }
    
    func initListeners() {
        
    }
    
    func initBankCard() {
        viewCard.backgroundColor = R.color.secondaryDark()
        viewCard.imageLogo.image = R.image.lightBankAyandehLogo()
        viewCard.labelBankName.text = "بانک آینده"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let smsText = textViewSmsCode.text.split(separator: "\n")
        smsText.forEach{ text in
            if text.count == 120 {
                textViewSmsCode.text = String(text)
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == R.color.buttonColor()?.withAlphaComponent(0.5) {
            textView.text = nil
            textView.textColor = R.color.buttonColor()
        }
        
        if textView == self.textViewAtmCode, textView.text.count == 8 {
            
            self.textViewSmsCode.becomeFirstResponder()
        }
        
       
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textViewSmsCode.text.isEmpty {
            textView.text = R.string.localizable.ph_sms_code()
            textView.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        }
        if textViewAtmCode.text.isEmpty {
            textView.text = R.string.localizable.ph_atm_code()
            textView.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        if textView == textViewAtmCode {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            return numberOfChars < 9
        }
        else {
            return true
        }
    }
   
    @IBAction func onButtonAddCode(_ sender: UIButton) {
        if textViewAtmCode.text.count != 8 || textViewSmsCode.text.count != 120 {
            UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_check_your_input(), color: R.color.errorColor()!)
        } else {
            let tokenPacket = textViewSmsCode.text + textViewAtmCode.text
            btConfirm.isEnabled = true
            presenter?.importToken(tokenPacket:  tokenPacket, card: card!, cryptoModuleId: self.cryptoModuleId!)
        }
    }
    
    func actionSheetButtonClicked() {
        
    }
    
    @IBAction func onConfirmClicked(_ sender: Any) {
    }
}
