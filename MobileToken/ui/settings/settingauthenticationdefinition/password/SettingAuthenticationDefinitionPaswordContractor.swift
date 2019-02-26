import Foundation

protocol SettingAuthenticationDefinitionPasswordViewProtocol: class {
    func showNotMatchError()
    func authenticationUpdatedAction()
    func temptDBCreated()
    
}

protocol SettingAuthenticationDefinitionPasswordPresenterProtocol {
    init(authenticationDefinitionPasswordView: SettingAuthenticationDefinitionPasswordViewProtocol)
    func hasMinimumLength(password: String) -> Bool
    func hasCapitalLetter(password: String) -> Bool
    func hasDigit(password: String) -> Bool
    func hasSpecialCharacters(password: String) -> Bool
    func checkPasswords(password: String, confirmpassword: String)
}
