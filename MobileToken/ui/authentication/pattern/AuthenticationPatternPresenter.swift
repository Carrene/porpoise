

import Foundation
import CryptoSwift
class AuthenticationPatternPresenter: AuthenticationPatternPresenterProtocol {
    
    unowned let authenticationPatternView: AuthenticationPatternViewProtocol
    var authentication: Authentication?
    
    required init(authenticationPatternView: AuthenticationPatternViewProtocol) {
        self.authenticationPatternView = authenticationPatternView
        getAuthentication()
    }
    
    func getAuthentication() {
        let authenticationRestRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print(error)
            } else {
                self!.authentication = repoResponse.value!
            }
        }
        authenticationRestRepository.get(onDone: onDataResponse)
    }
    
    func checkPatternCorrection(pattern: String) {
        if pattern.sha512() == authentication?.credential {
            authentication?.successAttempt()
            RealmConfiguration.sensitiveDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: pattern.bytes, salt: (self.authentication?.salt!.bytes)!)?.toHexString())!
            updateAuthentication(authentication: self.authentication!)
            getUser()
        } else {
            self.authentication?.failAttempt()
            updateAuthentication(authentication: self.authentication!)
            self.authenticationPatternView.showWrongPatternError()
            updateAuthentication(authentication: self.authentication!)
            if (authentication?.isLocked)! {
                self.authenticationPatternView.navigateToLockView()
            }
        }
    }
    
    func updateAuthentication(authentication: Authentication) {
        
        let authenticationRestRepository = AuthenticationRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                self!.authentication = repoResponse.value
            }
        }
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
    
    func getUser() {
        let userRepository = UserRepository()
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                self!.initScreenLocker()
                if repoResponse.value != nil {
                    self?.authenticationPatternView.navigateToCardList()
                } else {
                    self?.authenticationPatternView.navigateToInputPhoneNumber()
                }
            }
        }
        userRepository.get(identifier: 0, onDone: onDataResponse)
    }
    
    func initScreenLocker() {
        ScreenLocker.instance.resetTimer(time: 0)
        ScreenLocker.instance._init(time: ScreenLocker.SCREEN_LOCKER_TIME)
        ScreenLocker.instance.start()
    }
}
