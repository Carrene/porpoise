
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
        //initUIComponent()
//        // use bounds not frame or it'll be offset
        contentView.frame = bounds
//
//        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        initUIComponent()
//        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
    //NOTE(HAMED) check if changes is ok
    func loadViewFromNib() -> UIView! {
        //let bundle = Bundle(for: type(of: self))
        //let nib = UINib(nibName: "OtpViewDesignable", bundle: bundle)
        
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
