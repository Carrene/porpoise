import UIKit
import XLActionController

class ImportTokenViewController: BaseViewController,UITextViewDelegate,CardCellXibProtocol, ImportTokenViewProtocol {
   
    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textViewAtmCode: UITextView!
    @IBOutlet var labelAtmCode: UILabel!
    @IBOutlet var textViewSmsCode: UITextView!
    @IBOutlet var labelSmsCode: UILabel!
    @IBOutlet var buttonAddCode: UIButton!
    var card: Card?
    var presenter: ImportTokenPresenterProtokol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCard.setDelegate(cardCellXibProtocol: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter = ImportTokenPresenter(view: self)
        presenter?.getManagedCard(id: (card?.id)!)
    }
    
    func set(card: Card) {
        self.card = card
        
    }
    
    func setManagedCard(card: Card) {
        self.card = card
        textViewSmsCode.text = "178a6d2275ead9166099ad0095a47ccdd350383130ce43eb3ae976239efa904b06f6a7e920006b28b8995eaacf337c4bb50f3773459aa0f40559d6bb"
        textViewAtmCode.text = "93406ebd"
    }
    
    func initUIComponents() {
        buttonAddCode.layer.cornerRadius = 10
        viewCard.layer.cornerRadius = 10
        textViewAtmCode.layer.cornerRadius = 10
        textViewSmsCode.layer.cornerRadius = 10
        textViewAtmCode.delegate = self
        textViewSmsCode.delegate = self
        textViewSmsCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        textViewAtmCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        self.hideKeyboardWhenTappedAround()
        initBankCard()
    }
    
    func initListeners() {
        
    }
    
    func initBankCard() {
        viewCard.backgroundColor = R.color.ayandehColor()
        viewCard.imageLogo.image = R.image.bankAyandehLogo()
        viewCard.labelBankName.text = "بانک آینده"
        //viewCard.buttonActionSheet.isEnabled = false
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
//        if textViewAtmCode.text.count != 8 || textViewSmsCode.text.count != 120 {
            UIHelper.showSpecificSnackBar(message: "ورودی خود را کنترل کنید", color: R.color.errorColor()!)
            let tokenPacket = textViewSmsCode.text + textViewAtmCode.text
            presenter?.importToken(tokenPacket: tokenPacket, cryptoModuleId: .one, card: card!)
//        }
    }
    
    func actionSheetButtonClicked() {
        
    }
    
}
