
import Foundation
class AuthenticationDefinitionPatternPresenter: AuthenticationDefinitionPatternPresenterProtocol {

    var firstAttemptPattern: String?
    var secondAttemptPattern:String?
    unowned let authenticationDefinitionPatternView: AuthenticationDefinitionPatternViewProtocol
    
    required init(authenticationDefinitionPatternView: AuthenticationDefinitionPatternViewProtocol) {
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
                
            } else {
                self.firstAttemptPattern = nil
                self.secondAttemptPattern = nil
                self.authenticationDefinitionPatternView.showNotMatchError()
            }
        }
    }
    
    func updateAuthentication(credential: String) {
        let authentication = Authentication(credentials: credential.sha512(), authenticationType: AuthenticationTypeEnum.PATTERN)
        DispatchQueue.global(qos: .userInitiated).async {
            RealmConfiguration.sensitiveDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: credential.bytes, salt: authentication.salt!.bytes)?.toHexString())!
            DispatchQueue.main.async {
                let authenticationRestRepository = AuthenticationRepository()
                let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
                    if let error = repoResponse.error {
                        print("\(error)")
                    } else {
                        UIHelper.showSuccessfulSnackBar(message: R.string.localizable.sb_successfully_done())
                        self!.authenticationDefinitionPatternView.navigateToTabbar()
                        AuthenticationPatternPresenter.initScreenLocker()
                    }
                }
                authenticationRestRepository.update(authentication, onDone: onDataResponse)

            }
        }
    }
}
