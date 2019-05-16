import Foundation
class AuthenticationPasswordPresenter: AuthenticationPasswordPresenterProtocol {

    
    
    unowned let authenticationPasswordView: AuthenticationPasswordViewProtocol
    var authentication: Authentication?
    
    required init(authenticationPasswordView: AuthenticationPasswordViewProtocol) {
        self.authenticationPasswordView = authenticationPasswordView
        getAuthentication()
    }
    
    func getAuthentication(){
        let authenticationRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print(error)
            } else {
                self?.authentication = repoResponse.value
            }
        }
        authenticationRepository.get(onDone: onDataResponse)
    }
    
    func checkPasswordCorrection(password: String) {
        if password.sha512() == authentication?.credential {
            authentication?.successAttempt()
            Logger.instance.logEvent(event: ConstantHelper.AUTHENTICATION_LOG_EVENT, parameters: ["result": true as NSObject])
            DispatchQueue.global(qos: .userInitiated).async {
                RealmConfiguration.sensitiveDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: password.bytes, salt: (self.authentication?.salt!.bytes)!)?.toHexString())!
                DispatchQueue.main.async {
                    self.updateAuthentication(authentication: self.authentication!)
                    self.getAllUsers()
                }
            }
        } else {
            self.authentication?.failAttempt()
            Logger.instance.logEvent(event: ConstantHelper.AUTHENTICATION_LOG_EVENT, parameters: ["result": false as NSObject])
            updateAuthentication(authentication: self.authentication!)
            self.authenticationPasswordView.showWrongPasswordError(remainAttemps:(self.authentication?.remainedAttempts)!)
            updateAuthentication(authentication: self.authentication!)
            if (authentication?.isLocked)! {
                Logger.instance.logEvent(event: ConstantHelper.LOCK_APP_LOG_EVENT, parameters: nil)
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
//                AuthenticationPatternPresenter.initScreenLocker()
                if (repoResponse.value?.count)! > 0 {
                    self?.authenticationPasswordView.navigateToCardList()
                } else {
                    self?.authenticationPasswordView.navigateToInputPhoneNumber()
                }
            }
        }
        userRepository.getAll(onDone: onDataResponse)
    }

}
