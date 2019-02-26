

import UIKit
import PopupDialog

class SettingAuthenticationDefinitionViewController: UIViewController, SettingAuthenticationDefintionDelegate {
    
    @IBOutlet weak var authenticationTypeContainer: UIView!
    @IBOutlet weak var scAuthenticationType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        
        scAuthenticationType.layer.shadowRadius = 5
        scAuthenticationType.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        scAuthenticationType.layer.shadowOpacity = 0.15
        scAuthenticationType.removeBorders()
        
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
//        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
       
        
        let realmURL = RealmConfiguration.sensitiveDataConfiguration().fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                // handle error
            }
        }
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let documentDirectory = URL(fileURLWithPath: path)
            let originPath = documentDirectory.appendingPathComponent("tempt.realm")
            let destinationPath = documentDirectory.appendingPathComponent("sensitive.realm")
            try FileManager.default.moveItem(at: originPath, to: destinationPath)
        } catch {
            print(error)
        }
        showDialog()
    }
    
    func showDialog() {
    
        let popup = PopupDialog(title: "", message: R.string.localizable.alert_force_close())
        let okButton = DefaultButton(title: "OK", dismissOnTap: false) {
            exit(0)
        }
        popup.addButton(okButton)
        self.present(popup, animated: true, completion: nil)
    }
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: R.color.primary()!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: R.color.secondary()!), for: .selected, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: R.color.primary()!), for: .focused, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: R.color.primary()!), for: .highlighted, barMetrics: .default)
        //setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
