import Foundation

class SettingAuthenticationDefinitionPasswordPresenter: SettingAuthenticationDefinitionPasswordPresenterProtocol {
    
    unowned let authenticationDefinitionPasswordView: SettingAuthenticationDefinitionPasswordViewProtocol
    
    required init(authenticationDefinitionPasswordView: SettingAuthenticationDefinitionPasswordViewProtocol) {
        self.authenticationDefinitionPasswordView = authenticationDefinitionPasswordView
    }
    
    func hasMinimumLength(password: String) -> Bool{
        return PasswordValidator.hasPasswordMinimumLength(testStr: password)
    }
    
    func hasCapitalLetter(password: String) -> Bool{
        return PasswordValidator.hasPasswordCapitalLetter(testStr:password)
    }
    
    func hasDigit(password: String) -> Bool {
        return PasswordValidator.hasPasswordDigit(testStr:password)
    }
    
    func hasSpecialCharacters(password: String) -> Bool{
        return PasswordValidator.hasPasswordCustomCharacters(testStr:password)
    }
    
    func checkPasswords(password: String, confirmpassword: String) {
        if password == confirmpassword {
            updateAuthentication(credential: password)
        } else {
            authenticationDefinitionPasswordView.showNotMatchError()
        }
    }
    
    func updateAuthentication(credential: String) {
        let authentication = Authentication(credentials: credential.sha512(), authenticationType: AuthenticationTypeEnum.PASSWORD)
        
        RealmConfiguration.sensitiveDataEncryptionKey = (CryptoUtil.keyDerivationBasedOnPBE(pin: credential.bytes, salt: authentication.salt!.bytes)?.toHexString())!
        let authenticationRestRepository = AuthenticationRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                UIHelper.showSuccessfulSnackBar(message: R.string.localizable.sb_successfully_done())
                
                //self!.authenticationDefinitionPasswordView.navigateToProvisioning()
                AuthenticationPatternPresenter.initScreenLocker()
            }
        }
        authenticationRestRepository.update(authentication, onDone: onDataResponse)
    }
}
