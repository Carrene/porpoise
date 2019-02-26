import Foundation
import RealmSwift

class SettingAuthenticationDefinitionPatternPresenter: SettingAuthenticationDefinitionPatternPresenterProtocol {
    

    var firstAttemptPattern: String?
    var secondAttemptPattern:String?
    var authentication: Authentication?
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
            } else {
                self.firstAttemptPattern = nil
                self.secondAttemptPattern = nil
                self.authenticationDefinitionPatternView.showNotMatchError()
            }
        }
    }
    
    func updateAuthentication(credential: String) {
        let authentication = Authentication(credentials: credential.sha512(), authenticationType: AuthenticationTypeEnum.PATTERN)
        let authenticationRestRepository = AuthenticationRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                UIHelper.showSuccessfulSnackBar(message: R.string.localizable.sb_successfully_done())
                self!.createTempDB(credential: credential, authentication: authentication)
            }
        }
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
    
    func createTempDB(credential: String, authentication: Authentication) {
        DispatchQueue.global(qos: .userInitiated).async {
            RealmConfiguration.teptDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: credential.bytes, salt: authentication.salt!.bytes)?.toHexString())!
            DispatchQueue.main.async {
                autoreleasepool {
                    let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
                    try! realm.writeCopy(toFile: RealmConfiguration.temptDataConfiguration().fileURL!, encryptionKey: RealmConfiguration.temptDataConfiguration().encryptionKey)
                }
                self.authenticationDefinitionPatternView.temptDBCreated()
            }
        }
        
    }
}
