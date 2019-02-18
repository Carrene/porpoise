import UIKit
import RealmSwift
import IQKeyboardManager
import Firebase
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyBoard = UIStoryboard(resource: R.storyboard.main)
        self.window?.rootViewController = storyBoard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        self.window?.tintColor = R.color.eyeCatching()
        UILabel.appearance().font = R.font.iranSansMobileFaNum(size:16)
        UITextView.appearance().font = R.font.iranSansMobileFaNum(size: 16)
        UITextField.appearance().font = R.font.iranSansMobileFaNum(size: 16)
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:R.font.iranSansMobileMedium(size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        UINavigationBar.appearance().barTintColor = R.color.primary()
        UINavigationBar.appearance().tintColor = R.color.buttonColor()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : R.color.buttonColor()!,NSAttributedString.Key.font: R.font.iranSansMobileBold(size: 16)!]
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        print("\(String(describing: RealmConfiguration.sensitiveDataConfiguration().fileURL))")
//        print((Bundle.main.infoDictionary?["UrlEndPoint"] as! String).replacingOccurrences(of: "\\", with: ""))
//        print(Bundle.main.infoDictionary?["UrlPort"] as! String)
//        print(Bundle.main.infoDictionary?["InitialToken"] as! String)
//        var filePath: String!
//        #if DEBUG
//            print("[FIREBASE] Development mode.")
//            filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "debug")
//        #else
//            print("[FIREBASE] Production mode.")
//            filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "release")
//        #endif
//        let options = FirebaseOptions.init(contentsOfFile: filePath)!
        
//        FirebaseApp.configure(options: options)

//        let fileManager = FileManager.default
//
//        // Copy 'hello.swift' to 'subfolder/hello.swift'
//
//        do {
//            try fileManager.copyItem(atPath: "GoogleService-Info-r.plist", toPath: "GoogleService-Info.plist")
//        }
//        catch let error as NSError {
//            print("Ooops! Something went wrong: \(error)")
//        }
//        #if DEBUG
//
//        #else
//        do {
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//            let documentDirectory = URL(fileURLWithPath: path)
//            let originPath = documentDirectory.appendingPathComponent("release/GoogleService-Info-r.plist")
//            let destinationPath = documentDirectory.appendingPathComponent("GoogleService-Info.plist")
//            try FileManager.default.moveItem(at: originPath, to: destinationPath)
//        } catch {
//            print(error)
//        }
//
//        #endif
//        
        FirebaseApp.configure()
        
//        Fabric.sharedSDK().debug = true

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
        //
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if(ScreenLocker.instance.isRunning()){
            ScreenLocker.instance.stop()
            ScreenLocker.instance.lockScreen()
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//
//PATH_TO_GOOGLE_PLISTS="${PROJECT_DIR}/MobileToken"
//#if DEBUG
//cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-d.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
//#else
//cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-r.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
//#endif
