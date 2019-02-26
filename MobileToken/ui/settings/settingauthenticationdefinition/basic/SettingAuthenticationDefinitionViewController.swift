

import UIKit

class SettingAuthenticationDefinitionViewController: UIViewController, SettingAuthenticationDefintionDelegate {
    
    @IBOutlet weak var authenticationTypeContainer: UIView!
    @IBOutlet weak var scAuthenticationType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        authenticationTypeContainer.subviews.forEach({ $0.removeFromSuperview() })
        if sender.selectedSegmentIndex == 1 {
            embedVCPassword()
        } else {
            embedVCPattern()
        }
    }
    
    func initUIComponent() {
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.hidesBackButton = false
        let attr = NSDictionary(object: R.font.iranSansMobileBold(size: 16)!, forKey: NSAttributedString.Key.font as NSCopying)
        scAuthenticationType.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any] , for: .normal)
        embedVCPattern()
    }
    
    func embedVCPassword() {
        var vcPassword: SettingAuthenticationDefinitionPasswordViewController?
        vcPassword = R.storyboard.settingAuthenticationDefinition.settingAuthenticationDefinitionPasswordViewController()
        vcPassword?.setDelegate(authenticationDefinitionDelegate: self)
        vcPassword?.willMove(toParent: self)
        self.addChild(vcPassword!)
        authenticationTypeContainer.addSubview((vcPassword?.view)!)
        vcPassword?.view.frame = authenticationTypeContainer.bounds
    }
    
    func embedVCPattern() {
        var vcPattern: SettingAuthenticationDefinitionPatternViewController?
        vcPattern = R.storyboard.settingAuthenticationDefinition.settingAuthenticationDefinitionPatternViewController()
        vcPattern?.setDelegate(authenticationDefinitionDelegate: self)
        vcPattern?.willMove(toParent: self)
        self.addChild(vcPattern!)
        authenticationTypeContainer.addSubview((vcPattern?.view)!)
        vcPattern?.view.frame = authenticationTypeContainer.bounds
    }
    
    func backToSetting() {
        navigationController?.popViewController(animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        navigationItem.backBarButtonItem = backItem
    }
    
    func temptDBCreated() {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
       
        
//        let realmURL = RealmConfiguration.sensitiveDataConfiguration().fileURL!
//        let realmURLs = [
//            realmURL,
//            realmURL.appendingPathExtension("lock"),
//            realmURL.appendingPathExtension("note"),
//            realmURL.appendingPathExtension("management")
//        ]
//        for URL in realmURLs {
//            do {
//                try FileManager.default.removeItem(at: URL)
//            } catch {
//                // handle error
//            }
//        }
//        
//        do {
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//            let documentDirectory = URL(fileURLWithPath: path)
//            let originPath = documentDirectory.appendingPathComponent("tempt.realm")
//            let destinationPath = documentDirectory.appendingPathComponent("sensitive.realm")
//            try FileManager.default.moveItem(at: originPath, to: destinationPath)
//        } catch {
//            print(error)
//        }

    }
}

