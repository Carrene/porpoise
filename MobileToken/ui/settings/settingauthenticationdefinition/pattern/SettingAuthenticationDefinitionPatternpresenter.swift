import Foundation
class SettingAuthenticationDefinitionPatternPresenter: SettingAuthenticationDefinitionPatternPresenterProtocol {

    var firstAttemptPattern: String?
    var secondAttemptPattern:String?
    unowned let authenticationDefinitionPatternView: SettingAuthenticationDefinitionPatternViewProtocol
    
    required init(authenticationDefinitionPatternView: SettingAuthenticationDefinitionPatternViewProtocol) {
        self.authenticationDefinitionPatternView = authenticationDefinitionPatternView
    }
    
    func checkPattern(count: Int, password: String) {
        if self.firstAttemptPattern == nil {
            
            if count > 3 {
                self.firstAttemptPattern = password
                self.authenticationDefinitionPatternView.showTryForSecondTimeMessage()
            }else {
                self.authenticationDefinitionPatternView.showPatternMinPointError()
            }
        } else {
            self.secondAttemptPattern = password
            if self.secondAttemptPattern == self.firstAttemptPattern {
                updateAuthentication(credential: password)
//                #warning("key drivate")
//                RealmConfiguration.sensitiveDataEncryptionKey = "hamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhamedhame"
                
            } else {
                self.firstAttemptPattern = nil
                self.secondAttemptPattern = nil
                self.authenticationDefinitionPatternView.showNotMatchError()
            }
        }
    }
    
    func updateAuthentication(credential: String) {
        let authentication = Authentication(credentials: credential.sha512(), authenticationType: AuthenticationTypeEnum.PATTERN)
        RealmConfiguration.sensitiveDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: credential.bytes, salt: authentication.salt!.bytes)?.toHexString())!
        let authenticationRestRepository = AuthenticationRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                UIHelper.showSuccessfulSnackBar(message: R.string.localizable.sb_successfully_done())
                //self!.authenticationDefinitionPatternView.navigateToProvisioning()
                self!.initScreenLocker()
            }
        }
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
    
    func initScreenLocker() {
        ScreenLocker.instance._init(time: ScreenLocker.SCREEN_LOCKER_TIME)
        ScreenLocker.instance.start();
    }
}
