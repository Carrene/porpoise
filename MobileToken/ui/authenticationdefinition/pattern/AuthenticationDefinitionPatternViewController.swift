
import UIKit
import Foundation
import HUIPatternLockView_Swift
class AuthenticationDefinitionPatternViewController: UIViewController, AuthenticationDefinitionPatternViewProtocol {
    
    @IBOutlet weak var vPattern: HUIPatternLockView!

    var authenticationDefinitionDelegate: AuthenticationDefintionDelegate?
    var firstAttemptPattern: String?
    var secondAttemptPattern: String?
    var authenticationDefinitionPatternPresenter: AuthenticationDefinitionPatternPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationDefinitionPatternPresenter = AuthenticationDefinitionPatternPresenter(authenticationDefinitionPatternView: self)
        initUIComponent()
    }
    
    func initUIComponent() {
        
        self.vPattern.resetDotsState()
        self.vPattern.normalDotImage = R.image.patternDot()
        self.vPattern.highlightedDotImage = R.image.patternGrayDot()
        self.vPattern.dotWidth = 40
        configuareLockViewWithImages()
    }
    
    func setDelegate(authenticationDefinitionDelegate: AuthenticationDefintionDelegate) {
        
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
    
    private func configuareLockViewWithImages() {
        
        vPattern.didDrawPatternPassword = { (lockView: HUIPatternLockView, count: Int, password: String?) -> Void in
            guard count > 0 else {
                return
            }
            self.vPattern.resetDotsState()
            self.authenticationDefinitionPatternPresenter?.checkPattern(count: count, password: password!)
        }
    }
    
    func showNotMatchError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_patterns_not_match(), color: R.color.errorDark()!)

    }
    
    func showTryForSecondTimeMessage() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_try_for_second_time(), color: R.color.snackbarColor()!)

    }
    
    func showPatternMinPointError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_pattern_min_point_error(), color: R.color.errorDark()!)

    }
    
    func navigateToTabbar() {
        self.authenticationDefinitionDelegate?.navigateToTabbar()
    }
}

