import UIKit
import XLActionController

//TODO(Fateme) Action sheet on cards should be done on cardlist controller
class ImportTokenViewController: BaseViewController,UITextViewDelegate,CardCellXibProtocol {
    
    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textViewAtmCode: UITextView!
    @IBOutlet var labelAtmCode: UILabel!
    @IBOutlet var textViewSmsCode: UITextView!
    @IBOutlet var labelSmsCode: UILabel!
    @IBOutlet var buttonAddCode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCard.setDelegate(cardCellXibProtocol: self)
    }
    
    func initUIComponents() {
        buttonAddCode.layer.cornerRadius = 10
        viewCard.layer.cornerRadius = 10
        textViewAtmCode.layer.cornerRadius = 10
        textViewSmsCode.layer.cornerRadius = 10
        textViewAtmCode.delegate = self
        textViewSmsCode.delegate = self
        textViewSmsCode.font = R.font.iranSansMobile(size: 16)
        textViewAtmCode.font = R.font.iranSansMobile(size: 16)
        textViewSmsCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        textViewAtmCode.textColor = R.color.buttonColor()?.withAlphaComponent(0.5)
        initBankCard()
    }
    
    func initListeners() {
        
    }
    
    func initBankCard() {
        viewCard.backgroundColor = R.color.ayandehColor()
        viewCard.imageLogo.image = R.image.bankAyandehLogo()
        viewCard.labelBankName.text = "بانک آینده"
        viewCard.buttonActionSheet.isEnabled = false
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
        if textViewAtmCode.text.count < 9 || textViewSmsCode.text.count == 0 {
            UIHelper.showSpecificSnackBar(message: "ورودی خود را کنترل کنید", color: R.color.errorColor()!)
        }
    }
    
    func actionSheetButtonClicked() {
        
    }
    
}
