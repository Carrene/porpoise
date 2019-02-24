

import Foundation
import UIKit
import Onboard
import SwiftyGif

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
        
        let pageColors = [R.color.primary(), R.color.primary(), R.color.primary()]
        for i in 0..<3 {
            pages[i].viewWillAppearBlock = {
                //pages[i].view.backgroundColor = UIColor(netHex: Int(pageColors[i], radix: 16)!)
            }
            pages[i].topPadding = 50
            pages[i].underIconPadding = 50
            pages[i].underTitlePadding = 20
            pages[i].bottomPadding = 20
            pages[i].iconImageView.backgroundColor = R.color.primary()
            switch i {
            case 0:
                pages[0].iconImageView.image = R.image.noInternet()
                pages[0].iconHeight = 200
                pages[0].iconWidth = 200
                //pages[0].topPadding = 150
                //pages[0].underIconPadding = 70
                
            case 2:
                pages[2].iconImageView.image = R.image.forgetPassword()
                pages[2].iconHeight = 250
                pages[2].iconWidth = 250
            case 1:
                pages[1].iconImageView.image = R.image.security()
                pages[1].iconHeight = 250
                pages[1].iconWidth = 250
            default:
                break
            }
            pages[i].view.contentMode = .center
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
