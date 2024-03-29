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
        let authenticationRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print(error)
            } else {
                self!.authentication = repoResponse.value!
            }
        }
        authenticationRepository.get(onDone: onDataResponse)
    }
    
    func checkPatternCorrection(pattern: String) {
        if pattern.sha512() == authentication?.credential {
            authentication?.successAttempt()
             Logger.instance.logEvent(event: ConstantHelper.AUTHENTICATION_LOG_EVENT, parameters: ["result": true as NSObject])
            DispatchQueue.global(qos: .userInitiated).async {
               
                RealmConfiguration.sensitiveDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: pattern.bytes, salt: (self.authentication?.salt!.bytes)!)?.toHexString())!
                DispatchQueue.main.async {
                    self.updateAuthentication(authentication: self.authentication!)
                    self.getAllUsers()
                }
            }
        } else {
            self.authentication?.failAttempt()
             Logger.instance.logEvent(event: ConstantHelper.AUTHENTICATION_LOG_EVENT, parameters: ["result": false as NSObject])
            updateAuthentication(authentication: self.authentication!)
            self.authenticationPatternView.showWrongPatternError(remainAttemps:(self.authentication?.remainedAttempts)!)
            updateAuthentication(authentication: self.authentication!)
            if (authentication?.isLocked)! {
                Logger.instance.logEvent(event: ConstantHelper.LOCK_APP_LOG_EVENT, parameters: nil)
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
        let a = UIView()
        a.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
    
    func getAllUsers() {
        let userRepository = UserRepository()
        let onDataResponse: ((RepositoryResponse<[User]>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
//                AuthenticationPatternPresenter.initScreenLocker()
                if (repoResponse.value?.count)! > 0 {
                    self?.authenticationPatternView.navigateToCardList()
                } else {
                    self?.authenticationPatternView.navigateToInputPhoneNumber()
                }
            }
        }
        userRepository.getAll(onDone: onDataResponse)
    }
    
    static func initScreenLocker(callBack: @escaping () -> ()) {
        let setting = AuthenticationPatternPresenter.getSetting()
        ScreenLocker.instance._init(time: setting.lockTimer, callBack: callBack)
        ScreenLocker.instance.resetTimer(time: setting.lockTimer)
    }
    
    static func getSetting() -> Setting{
        var appSetting: Setting?
        let settingRepository = SettingRepository()
        let onDataResponse: ((RepositoryResponse<Setting>) -> ()) = { repoResponse in
            if repoResponse.error != nil {
                UIHelper.showFailedSnackBar()
            } else {
                if let setting = repoResponse.value {
                    appSetting = setting
                } else {
                    UIHelper.showFailedSnackBar()
                }
            }
        }
        settingRepository.get(onDone: onDataResponse)
        return appSetting!
    }
}
