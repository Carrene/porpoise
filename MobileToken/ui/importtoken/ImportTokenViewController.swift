import UIKit
import XLActionController

protocol ImportToeknDelegate {
    func importedToken(card: Card)
}

class ImportTokenViewController: BaseViewController,UITextViewDelegate, ImportTokenViewProtocol {
   
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter = ImportTokenPresenter(view: self)
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
        viewCard.layer.shadowPath = UIBezierPath(roundedRect: viewCard.bounds, cornerRadius: 10).cgPath
        viewCard.layer.shadowRadius = 5
        viewCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCard.layer.shadowOpacity = 0.5
        viewCard.layer.shadowColor = R.color.buttonColor()!.cgColor
        viewCard.layer.borderWidth = 0
        viewCard.imagePlus.isHidden = true
        viewCard.buttonActionSheet.isHidden = true
        
        textViewAtmCode.layer.cornerRadius = 5
        textViewSmsCode.layer.cornerRadius = 5
        if self.cryptoModuleId == Token.CryptoModuleId.one {
            self.viewCard.labelBottomTitle.text = R.string.localizable.everywhere_firstpassword()
        } else {
            self.viewCard.labelBottomTitle.text = R.string.localizable.everywhere_secondpassword()
        }
        textViewAtmCode.delegate = self
        textViewSmsCode.delegate = self
        textViewSmsCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        textViewAtmCode.layer.borderWidth = 2
        textViewAtmCode.layer.borderColor = R.color.buttonColor()!.cgColor
        textViewAtmCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        labelAtmCode.font = R.font.iranSansMobile(size: 12)
        labelSmsCode.font = R.font.iranSansMobile(size: 12)
        textViewSmsCode.layer.borderWidth = 2
        textViewSmsCode.layer.borderColor = R.color.buttonColor()!.cgColor
        self.hideKeyboardWhenTappedAround()
        initBankCard()
    }
    
    func initListeners() {
        
    }
    
    func initBankCard() {
        viewCard.backgroundColor = R.color.secondaryDark()
        viewCard.imageLogo.image = BankUtil.getLightLogo(bank: (card?.bank)!)
        viewCard.labelCardName.text = card?.cardName
        viewCard.labelBankName.text = card?.bank?.name
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textViewAtmCode.text.count != 8 || textViewSmsCode.text.count != 120 {
//            UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_check_your_input(), color: R.color.errorDark()!)
            
            btConfirm.isEnabled = false
        } else {
            btConfirm.isEnabled = true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == R.color.buttonColor()?.withAlphaComponent(0.5) {
            textView.text = nil
            textView.textColor = R.color.buttonColor()
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
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if textView == textViewAtmCode {
            
            return numberOfChars < 9
        }
        else {
            let smsText = text.components(separatedBy: CharacterSet(charactersIn: "\n "))
            smsText.forEach{ splitedText in
                if splitedText.count == 120 && smsText.count > 1 {
                    textViewSmsCode.text = String(splitedText)
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
        let tokenPacket = textViewSmsCode.text + textViewAtmCode.text
        presenter?.importToken(tokenPacket:  tokenPacket, card: card!, cryptoModuleId: self.cryptoModuleId!)
    }
}
