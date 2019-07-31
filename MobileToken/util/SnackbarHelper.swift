
import TTGSnackbar
import Foundation

class SnackBarHelper:TTGSnackbar {
    
    override init(message: String, duration: TTGSnackbarDuration) {
        super.init(message: message, duration: duration)
    }
    
    init(message: String,color:UIColor, duration: TTGSnackbarDuration) {
        super.init(message: message, duration: duration)
        self.messageTextFont = UIHelper.getFont(size: 14)
        self.messageTextAlign = .right
        self.backgroundColor=color
        self.messageTextColor=R.color.primary()!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
