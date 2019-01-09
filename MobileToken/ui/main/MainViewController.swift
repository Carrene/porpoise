import UIKit

class MainViewController: UINavigationController {

    var hasWizardShown = false
    var authentication : Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfNewUser()
        initPages()
    }
    
    func initPages() {
        if authentication == nil {
            if hasWizardShown {
                navigatoToAuthenticationDefinition()
            }
            else {
                intro()
            }
        }
        else {
            navigateToAuthentication()
        }
    }
    
    func checkIfNewUser()  {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ())  = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("error")
            } else {
                self?.authentication = repoResponse.value
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func intro() {
        let onIntroEnd = { [weak self] in
            //self!.navigationController?.popViewController(animated: true)
        }
        let introVC = IntroViewController.newInstance(withIntroEndAction: onIntroEnd)
        present(introVC, animated: true, completion: nil)
        hasWizardShown = true
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

}
