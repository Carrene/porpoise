
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
        
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
  
    
    @IBAction func onButtonActionSheet(_ sender: UIButton) {
    }
    
    func initUIComponent() {
        imageLogo.layer.cornerRadius = 10
    }
    
    func loadViewFromNib() -> UIView! {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "CardCell", bundle: bundle)
        let view = R.nib.cardCell.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
