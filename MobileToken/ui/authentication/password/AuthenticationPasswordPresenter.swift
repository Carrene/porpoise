

import Foundation
class AuthenticationPasswordPresenter: AuthenticationPasswordPresenterProtocol {
    
    unowned let authenticationPasswordView: AuthenticationPasswordViewProtocol
    var authentication: Authentication?
    
    required init(authenticationPasswordView: AuthenticationPasswordViewProtocol) {
        self.authenticationPasswordView = authenticationPasswordView
        getAuthentication()
    }
    
    func getAuthentication(){
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print(error)
            } else {
                self?.authentication = repoResponse.value
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func checkPasswordCorrection(password: String) {
        if password.sha512() == authentication?.credential {
            authentication?.successAttempt()
            RealmConfiguration.sensitiveDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: password.bytes, salt: (authentication?.salt!.bytes)!)?.toHexString())!
            updateAuthentication(authentication: self.authentication!)
             getAllUsers()
        } else {
            self.authentication?.failAttempt()
            updateAuthentication(authentication: self.authentication!)
            self.authenticationPasswordView.showWrongPasswordError()
            updateAuthentication(authentication: self.authentication!)
            if (authentication?.isLocked)! {
                self.authenticationPasswordView.navigateToLockView()
            }
        }
    }
    
    func updateAuthentication(authentication: Authentication) {
        
        let authenticationRepository = AuthenticationRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                self!.authentication = repoResponse.value
            }
        }
        authenticationRepository.update(authentication, onDone: onDataResponse)
    }
    
    func getAllUsers() {
        let userRepository = UserRepository()
        let onDataResponse: ((RepositoryResponse<[User]>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                self!.initScreenLocker()
                if (repoResponse.value?.count)! > 0 {
                    self?.authenticationPasswordView.navigateToCardList()
                } else {
                    self?.authenticationPasswordView.navigateToInputPhoneNumber()
                }
            }
        }
        userRepository.getAll(onDone: onDataResponse)
    }
    
    func initScreenLocker() {
        ScreenLocker.instance._init(time: MainViewController.SCREEN_LOCKER_TIME!)
        ScreenLocker.instance.start()
    }
}
