import UIKit

@IBDesignable

class OtpViewDesignable: UIView {
    
    @IBOutlet weak var vComponent: UIView!
    @IBOutlet weak var lbOtp: UITextField!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var vProgress: UIProgressView!
    @IBOutlet weak var btCopy: UIButton!
    var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
//        initUIComponent()
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        initUIComponent()
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
    //NOTE(HAMED) check if changes is ok
    func loadViewFromNib() -> UIView! {
        //let bundle = Bundle(for: type(of: self))
        //let nib = UINib(nibName: "OtpViewDesignable", bundle: bundle)
       
        let nib = UINib(resource: R.nib.otpViewDesignable)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func initUIComponent() {
        vProgress.progress = 0
        vProgress.progressViewStyle = .bar
        vComponent.layer.masksToBounds = true
        vComponent.layer.cornerRadius = 5
        btCopy.layer.masksToBounds = true
        btCopy.layer.cornerRadius = 5
        vProgress.progressViewStyle = .bar
        lbOtp.font = R.font.iranSansMobileFaNum(size: 22)
        lbOtp.textColor = .red
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.initCopy))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func initCopy() {
        UIPasteboard.general.string = lbOtp.text!.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        SnackBarHelper.init(message: R.string.localizable.sb_password_copied(), color: R.color.snackbarColor()!, duration: .short).show()
        Logger.instance.logEvent(event: ConstantHelper.COPY_OTP_LOG_EVENT, parameters: nil)
    }
}

