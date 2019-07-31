
import UIKit
@IBDesignable

class CardCellXibView: UIView {
    
    @IBOutlet weak var imageShowPassword: UIImageView!
    var contentView : UIView!
    @IBOutlet var imageLogo: UIImageView!
    @IBOutlet var labelBankName: UILabel!
    @IBOutlet var labelCardName: UILabel!
    @IBOutlet var stackViewCardNumber: UIStackView!
    @IBOutlet var buttonActionSheet: UIButton!
    @IBOutlet var labelTokenNumber: UILabel!
    
    @IBOutlet var labelCardNumber: [UILabel]!
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        initUIComponent()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView)
    }
    
  
    
    @IBAction func onButtonActionSheet(_ sender: UIButton) {
    }
    
    func initUIComponent() {
        imageLogo.layer.cornerRadius = 10
    }
    
    func loadViewFromNib() -> UIView! {
        let view = R.nib.cardCell.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
