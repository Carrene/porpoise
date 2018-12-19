
import UIKit
import Foundation
import HUIPatternLockView_Swift
class SettingAuthenticationDefinitionPatternViewController: UIViewController, SettingAuthenticationDefinitionPatternViewProtocol {

    
    @IBOutlet var viewPattern: HUIPatternLockView!
    

    var authenticationDefinitionDelegate: SettingAuthenticationDefintionDelegate?
    var firstAttemptPattern: String?
    var secondAttemptPattern: String?
    var authenticationDefinitionPatternPresenter: SettingAuthenticationDefinitionPatternPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationDefinitionPatternPresenter = SettingAuthenticationDefinitionPatternPresenter(authenticationDefinitionPatternView: self)
        initUIComponent()
    }
    
    func initUIComponent() {
        
        self.viewPattern.resetDotsState()
        self.viewPattern.normalDotImage = #imageLiteral(resourceName: "patternGrayDot")
        self.viewPattern.highlightedDotImage = #imageLiteral(resourceName: "patternDot")
        self.viewPattern.dotWidth = 25
        configuareLockViewWithImages()
    }
    
    func setDelegate(authenticationDefinitionDelegate: SettingAuthenticationDefintionDelegate) {
        
        self.authenticationDefinitionDelegate = authenticationDefinitionDelegate
    }
    
    private func configuareLockViewWithImages() {
        
        viewPattern.didDrawPatternPassword = { (lockView: HUIPatternLockView, count: Int, password: String?) -> Void in
            guard count > 0 else {
                return
            }
            self.viewPattern.resetDotsState()
            self.authenticationDefinitionPatternPresenter?.checkPattern(count: count, password: password!)
        }
    }
    
    func showNotMatchError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_not_match(), color: R.color.errorColor()!)

    }
    
    func showTryForSecondTimeMessage() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_try_for_second_time(), color: R.color.secondary()!)

    }
    
    func showPatternMinPointError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_pattern_min_point_error(), color: R.color.errorColor()!)

    }
    
    func navigateToProvisioning() {
        self.authenticationDefinitionDelegate?.navigateToProvisioning()
    }
}

