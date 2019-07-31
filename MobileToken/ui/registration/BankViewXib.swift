
import UIKit
@IBDesignable

class BankViewXib: UIView {
    @IBOutlet var imageLogo: UIImageView!
    @IBOutlet var labelBank: UILabel!
    @IBOutlet var vComponent: UIView!
    
    var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        initUIComponent()
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView! {
        let nib = UINib(resource: R.nib.bankView)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func initUIComponent() {
        vComponent.layer.masksToBounds = true
        vComponent.layer.cornerRadius = 5
        vComponent.layer.borderColor = R.color.secondary()!.cgColor
        vComponent.layer.borderWidth = 2
        labelBank.font = R.font.iranSansMobileFaNum(size: 22)
    }

}
