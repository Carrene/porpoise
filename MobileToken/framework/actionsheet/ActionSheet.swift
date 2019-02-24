
import Foundation
import UIKit
import XLActionController

open class ActionSheet: ActionCell {
    
    @IBOutlet var viewCell: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var viewDisable: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize() {
        backgroundColor = R.color.primary()
        label.textColor = R.color.buttonColor()
        let backgroundView = UIView()
        backgroundView.backgroundColor = R.color.primaryLight()
        label.textColor = R.color.buttonColor()
        selectedBackgroundView = backgroundView
        separatorView?.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0)
    }
}
