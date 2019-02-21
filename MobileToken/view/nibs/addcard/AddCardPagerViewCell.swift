
import UIKit
import FSPagerView

protocol AddCardPagerViewCellProtocol {
    func addCardDetail(cardName:String,selectedBank:Bank)
}

class AddCardPagerViewCell: FSPagerViewCell {
    
    @IBOutlet var viewAddCard: UIView!
    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textFieldCardName: UITextField!
    private var addCardPagerViewCellProtocol : AddCardPagerViewCellProtocol?
    private var bank:Bank?
    @IBOutlet var buttonAddCard: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 10
        viewCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewCard.layer.borderWidth = 0.5
        viewCard.labelCardName.text = R.string.localizable.lb_cardName()
        viewCard.buttonActionSheet.isEnabled = false
        viewCard.labelBottomTitle.text = R.string.localizable.lb_add_new_bank()
        viewCard.stackViewCardNumber.isHidden = true
        viewAddCard.layer.cornerRadius = 10
        viewAddCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewAddCard.layer.borderWidth = 0.5
        textFieldCardName.layer.cornerRadius = 10
        textFieldCardName.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        textFieldCardName.layer.borderWidth = 2
        textFieldCardName.attributedPlaceholder = NSAttributedString(string: R.string.localizable.lb_desired_card_name(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
        
    }
    
    func setDelegate(addCardPagerViewCellProtocol:AddCardPagerViewCellProtocol) {
        self.addCardPagerViewCellProtocol = addCardPagerViewCellProtocol
    }
    
    func setBank(bank:Bank) {
        self.bank = bank
        self.viewCard.imageLogo.image = BankUtil.getLogo(bank: bank)
        viewCard.labelBankName.text = self.bank!.name
    }
    
    @IBAction func onAddCardButton(_ sender: UIButton) {
        if textFieldCardName.text != nil {
            buttonAddCard.isEnabled = true
            addCardPagerViewCellProtocol?.addCardDetail(cardName: textFieldCardName.text!, selectedBank: self.bank!)
            self.textFieldCardName.text = ""
        }
    }
    
    @IBAction func onDoneKeyboard(_ sender: UITextField) {
        if textFieldCardName.text != nil {
            
        }
    }
    
}
