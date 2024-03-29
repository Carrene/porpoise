
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
    @IBOutlet var labelTextfield: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 10
        buttonAddCard.layer.cornerRadius = 10
        buttonAddCard.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        labelTextfield.font = R.font.iranSansMobile(size: 12)
        viewCard.buttonActionSheet.isHidden = true
        viewCard.imageShowPassword.isHidden = true
        viewAddCard.layer.cornerRadius = 10
        viewAddCard.layer.shadowPath = UIBezierPath(roundedRect: viewAddCard.bounds, cornerRadius: 10).cgPath
        viewAddCard.layer.shadowRadius = 1
        viewAddCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewAddCard.layer.shadowOpacity = 0.1
        viewAddCard.layer.shadowColor = R.color.primaryLight()?.withAlphaComponent(0.15).cgColor
        viewAddCard.layer.borderWidth = 0
        
        
        viewCard.layer.cornerRadius = 10
        viewCard.layer.shadowPath = UIBezierPath(roundedRect: viewCard.bounds, cornerRadius: 10).cgPath
        viewCard.layer.shadowRadius = 5
        viewCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        viewCard.layer.shadowOpacity = 0.1
        viewCard.layer.backgroundColor = R.color.primaryLight()?.cgColor
        viewCard.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        
        
        viewCard.labelCardName.text = R.string.localizable.lb_cardName()
        viewCard.stackViewCardNumber.isHidden = false
        viewCard.labelTokenNumber.isHidden = true
        textFieldCardName.layer.cornerRadius = 5
        textFieldCardName.layer.borderColor = R.color.buttonColor()!.cgColor
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
        viewCard.labelBankName.text = BankUtil.getName(bank: self.bank!)
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
