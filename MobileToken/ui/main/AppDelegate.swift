import UIKit
import RealmSwift
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyBoard = UIStoryboard(resource: R.storyboard.main)
        self.window?.rootViewController = storyBoard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        self.window?.tintColor = R.color.eyeCatching()
        UILabel.appearance().font = R.font.iranSansMobile(size: 16)
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:R.font.iranSansMobileMedium(size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        UINavigationBar.appearance().barTintColor = R.color.primary()
        UINavigationBar.appearance().tintColor = R.color.buttonColor()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : R.color.buttonColor()!,NSAttributedString.Key.font: R.font.iranSansMobileBold(size: 16)!]
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
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

