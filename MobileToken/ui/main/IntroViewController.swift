import Foundation
import UIKit
import Onboard

class IntroViewController {
    
    public static func newInstance(withIntroEndAction introEndAction: @escaping (() -> Void) = { }) -> OnboardingViewController {
        var onboardingVC = OnboardingViewController()
        func onIntroEnd() {
            introEndAction()
            onboardingVC.dismiss(animated: true, completion: nil)
        }
        
        var pages = [OnboardingContentViewController]()
        
        var title = R.string.localizable.intro1Title()
        var description = R.string.localizable.intro1Description()
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: nil, buttonText: nil, action: nil))
        
        title = R.string.localizable.intro2Title()
        description = R.string.localizable.intro2Description()
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: nil, buttonText: nil, action: nil))
        
        title = R.string.localizable.intro3Title()
        description = R.string.localizable.intro3Description()
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: nil, buttonText: nil, action: nil))
        
        title = R.string.localizable.intro4Title()
        description = R.string.localizable.intro4Description()
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: nil, buttonText: nil, action: nil))
        
        title = R.string.localizable.intro5Title()
        description = R.string.localizable.intro5Description()
        let buttonTitle  = R.string.localizable.lb_enter_program()
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: nil, buttonText: buttonTitle, action: { onIntroEnd() }))
        
        
        
        pages.forEach() { element in
            element.bodyLabel.font = R.font.iranSansMobile(size: 16)
            element.bodyLabel.textColor = R.color.buttonColor()
            element.titleLabel.textColor = R.color.buttonColor()
            element.titleLabel.font = R.font.iranSansMobileBold(size: 16)
            element.actionButton.titleLabel?.font = R.font.iranSansMobileBold(size: 16)
            element.actionButton.setTitleColor(R.color.secondary(), for: .normal)
        }
        
        let pageImages = [UIImage(named:"introDevice"),UIImage(named:"introAtm-screen-menu"),UIImage(named:"introAtm-screen-pass"),UIImage(named:"introReceipt"),UIImage(named:"introDevice-pass")]
        for i in 0..<5 {
            pages[i].viewWillAppearBlock = {
                pages[i].iconImageView.image = pageImages[i]
                
            }
            pages[i].topPadding = 100
            pages[i].underIconPadding = 70
            pages[i].underTitlePadding = 16
            pages[i].bottomPadding = 20
            pages[i].iconImageView.backgroundColor = R.color.primary()
            pages[i].iconHeight = 250
            pages[i].iconWidth = 250
            //pages[i].view.contentMode = .center
            
        }
        
        onboardingVC = OnboardingViewController.onboard(withBackgroundImage: nil, contents: pages)
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.shouldMaskBackground = false
        onboardingVC.shouldBlurBackground = false
        onboardingVC.fadePageControlOnLastPage = false
        onboardingVC.pageControl.pageIndicatorTintColor = UIColor.black
        onboardingVC.pageControl.currentPageIndicatorTintColor = R.color.secondaryLight()
        onboardingVC.skipButton.setTitleColor(R.color.secondary(), for: .normal)
        onboardingVC.skipButton.setTitle(R.string.localizable.skip(), for: .normal)
        onboardingVC.skipButton.titleLabel?.font = R.font.iranSansMobileBold(size: 16)
        onboardingVC.allowSkipping = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        onboardingVC.view.backgroundColor = R.color.primary()
        onboardingVC.skipHandler = { onIntroEnd() }
        return onboardingVC
    }
}
