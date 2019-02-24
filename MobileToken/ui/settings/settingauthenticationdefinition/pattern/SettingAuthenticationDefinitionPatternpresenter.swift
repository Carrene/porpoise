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
                
                AuthenticationPatternPresenter.initScreenLocker()
            }
        }
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
    
    func createTempDB(credential: String) {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("tempt.realm")
        let newKey = CryptoUtil.keyDerivationBasedOnPBE(pin: credential.bytes, salt: authentication!.salt!.bytes)?.toHexString()
        let newKeyData = newKey!.data(using: String.Encoding.utf8, allowLossyConversion: false)
        print("keyTempt\(newKeyData!.toHexString())")
        addSensitiveAgain(newKey: newKey!)
    }
    
    func addSensitiveAgain(newKey: String) {
        autoreleasepool {
            RealmConfiguration.sensitiveDataEncryptionKey = newKey
            let realm = try! Realm(configuration: RealmConfiguration.sensitiveDataConfiguration())
            try! realm.writeCopy(toFile: RealmConfiguration.sensitiveDataConfiguration().fileURL!, encryptionKey: RealmConfiguration.sensitiveDataConfiguration().encryptionKey)
        }
    }
}
