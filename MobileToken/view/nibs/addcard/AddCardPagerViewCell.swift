
import UIKit
import FSPagerView

class AddCardPagerViewCell: FSPagerViewCell {
    
    @IBOutlet var viewAddCard: UIView!
    @IBOutlet var viewCard: CardCellXibView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 10
        viewCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewCard.layer.borderWidth = 0.5
        viewCard.labelTitle.text = "نام کارت"
        viewCard.buttonActionSheet.isHidden = true
        viewCard.labelTitle2.isHidden = true
        viewAddCard.layer.cornerRadius = 10
        viewAddCard.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewAddCard.layer.borderWidth = 0.5
        
    }
    
    

}
