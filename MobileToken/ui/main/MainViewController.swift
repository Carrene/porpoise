import UIKit
import DTTJailbreakDetection
import RealmSwift

class MainViewController: UINavigationController {

    var hasWizardShown = false
    var authentication : Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R.color.primary()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfNewUser()
        initPages()
    }
   
    func initPages() {
        if DTTJailbreakDetection.isJailbroken() {
            sendJailBrokenDeviceToServer()
        }
        else{
            if authentication == nil {
                if UserDefaults.standard.bool(forKey: "hasWizardShown") {
                    navigatoToAuthenticationDefinition()
                }
                else {
                    intro()
                }
            }
            else {
                if (authentication?.isLocked)! {
                    navigateToAppLocked()
                } else {
                    navigateToAuthentication()
                }
            }
        }
    }
    
    func checkIfNewUser()  {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ())  = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print(error)
            } else {
                self?.authentication = repoResponse.value
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func intro() {
        let onIntroEnd = { [weak self] in
            
        }
        let introVC = IntroViewController.newInstance(withIntroEndAction: onIntroEnd)
        present(introVC, animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "hasWizardShown")
        
    }
    
    func navigateToAppLocked() {
        performSegue(withIdentifier: R.segue.mainViewController.toapplicationLocked.identifier, sender: self)
    }
    
    func navigateToAuthentication() {
        performSegue(withIdentifier: R.segue.mainViewController.navigateToAuthentication.identifier, sender: self)
    }

    func navigatoToAuthenticationDefinition() {
        performSegue(withIdentifier: R.segue.mainViewController.navigatoToAuthenticationDefinition.identifier, sender: self)
    }

    func navigateToTabbar() {
        performSegue(withIdentifier: R.segue.mainViewController.navigateToTabbar.identifier, sender: self)
    }
    
    func navigateToImportToken() {
        performSegue(withIdentifier: R.segue.mainViewController.navigatoToImportToken.identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.mainViewController.navigateToTabbar.identifier {
            (segue.destination as! TabBarViewController).selectedIndex = 1
        }
    }
    
    fileprivate func sendJailBrokenDeviceToServer() {
        do {
            remove(realmURL: Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().appendingPathComponent("sensitive.realm"))
    
            remove(realmURL: Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().appendingPathComponent("insensitive.realm"))
            
        } catch {
            
            
        }
        exit(0)
    }
    
    func remove(realmURL: URL) {
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management"),
            ]
        for URL in realmURLs {
            try? FileManager.default.removeItem(at: URL)
        }
    }
    
}
