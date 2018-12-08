//
//  IntroViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/13/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

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
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: UIImage(gifName:"no-internet"), buttonText: nil, action: nil))
        
        title = R.string.localizable.intro2Title()
        description = R.string.localizable.intro2Description()
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: UIImage(gifName: "forget_password"), buttonText: nil, action: nil))
        
        title = R.string.localizable.intro3Title()
        description = R.string.localizable.intro3Description()
        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: UIImage(gifName: "security"), buttonText: nil, action: { onIntroEnd() }))
        
//        title = NSLocalizedString("intro4Title", comment: "")
//        var buttonTitle  = NSLocalizedString("btIntroEnd", comment: "")
//        description = NSLocalizedString("intro4Description", comment: "")
//        pages.append(OnboardingContentViewController.content(withTitle: title, body: description, image: UIImage(named: "introImage4"), buttonText: buttonTitle, action: { onIntroEnd() }))
        
        pages.forEach() { element in
            element.bodyLabel.font = R.font.iranSansMobile(size: 16)
            element.titleLabel.font = R.font.iranSansMobileBold(size: 16)
            element.actionButton.titleLabel?.font = R.font.iranSansMobileBold(size: 16)
        }
        
        let pageColors = ["192835", "192835", "192835"]
        for i in 0..<3 {
            pages[i].viewWillAppearBlock = {
                pages[i].view.backgroundColor = UIColor(netHex: Int(pageColors[i], radix: 16)!)
            }
            let h = pages[i].iconHeight
            pages[i].topPadding = pages[i].iconHeight * ( 0.25 )
            pages[i].underIconPadding = pages[i].iconHeight * ( -0.15 ) - h
            pages[i].underTitlePadding = pages[i].iconHeight * ( 0.2 ) + h
            pages[i].bottomPadding = 0
        }
        
        onboardingVC = OnboardingViewController.onboard(withBackgroundImage: nil, contents: pages)
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.shouldMaskBackground = false
        onboardingVC.shouldBlurBackground = false
        onboardingVC.fadePageControlOnLastPage = false
        onboardingVC.pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        onboardingVC.skipButton.setTitleColor(UIColor.white, for: .normal)
        onboardingVC.skipButton.setTitle(R.string.localizable.next(), for: .normal)
        onboardingVC.skipButton.titleLabel?.font = R.font.iranSansMobileBold(size: 16)
        onboardingVC.allowSkipping = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        onboardingVC.view.backgroundColor = UIColor.blue
        onboardingVC.skipHandler = { onIntroEnd() }
        return onboardingVC
    }
}
