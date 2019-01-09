import Foundation

class AuthenticationPresenter: AuthenticationPresenterProtocol {
    
    unowned let authenticationView: AuthenticationViewProtocol
    required init(authenticationView: AuthenticationViewProtocol) {
        self.authenticationView = authenticationView
    }
    
    func getAuthentication() {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print(error)
            } else {
                if let authentication = repoResponse.value, !authentication.isLocked {
                    if authentication.authenticationType == AuthenticationTypeEnum.PASSWORD {
                        self?.authenticationView.embedVCPassword(authentication:repoResponse.value!)
                    } else {
                        self?.authenticationView.embedVCPattern(authentication: repoResponse.value!)
                    }
                } else {
                    self?.authenticationView.navigateToLockView()
                }
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    
}
