import UIKit
import HUIPatternLockView_Swift
class AuthenticationPatternViewController: UIViewController, AuthenticationPatternViewProtocol {
    
    @IBOutlet weak var vPattern: HUIPatternLockView!
    
    var authenticationDelegate: AuthenticationDelegate?
    var authenticationPatternPresenter: AuthenticationPatternPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.authenticationPatternPresenter = AuthenticationPatternPresenter(authenticationPatternView: self)
        initUIComponent()
    }
    
    func setDelegate(authenticationDelegate:AuthenticationDelegate) {
        self.authenticationDelegate = authenticationDelegate
    }
    
    func initUIComponent() {
        vPattern.resetDotsState()
        vPattern.normalDotImage = R.image.patternDot()
        vPattern.highlightedDotImage = R.image.patternGrayDot()
        vPattern.dotWidth = 40
        configuareLockViewWithImages()
    }
    
    private func configuareLockViewWithImages() {
        vPattern.didDrawPatternPassword = { (lockView: HUIPatternLockView, count: Int, password: String?) -> Void in
            guard count > 3 else {
                self.vPattern.resetDotsState()
                 UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_pattern_min_point_error(), color: R.color.errorDark()!)
                return
            }
            self.vPattern.resetDotsState()
            self.authenticationPatternPresenter?.checkPatternCorrection(pattern: password!)
        }
    }
    
    func showWrongPatternError(remainAttemps:Int) {
        let message = R.string.localizable.sb_wrong_pattern() + "." + " شما \(remainAttemps) فرصت دیگر دارید "
        UIHelper.showSpecificSnackBar(message: message, color: R.color.errorDark()!)
    }
    
    func navigateToCardList() {
        self.authenticationDelegate?.navigateToCardList()
    }
    
    func navigateToInputPhoneNumber() {
        self.authenticationDelegate?.navigateToInputPhoneNumber()
    }
    
    func navigateToLockView() {
        self.authenticationDelegate?.navigateToLockView()
    }
}
