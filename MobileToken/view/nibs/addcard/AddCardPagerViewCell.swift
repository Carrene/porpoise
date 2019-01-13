
import UIKit
import FSPagerView

class AddCardPagerViewCell: FSPagerViewCell {
    
    @IBOutlet var viewAddCard: UIView!
    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 10
        viewCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewCard.layer.borderWidth = 0.5
        viewCard.labelCardName.text = "نام کارت"
        viewCard.buttonActionSheet.isHidden = true
        viewCard.labelBottomTitle.isHidden = true
        viewAddCard.layer.cornerRadius = 10
        viewAddCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewAddCard.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        textField.layer.borderWidth = 0.5
    }
    
    

}
