import Foundation

protocol AuthenticationDefinitionPasswordViewProtocol: class {
    func showNotMatchError()
    func navigateToTabbar()
    func authenticationUpdatedAction()
    
}

protocol AuthenticationDefinitionPasswordPresenterProtocol {
    init(authenticationDefinitionPasswordView: AuthenticationDefinitionPasswordViewProtocol)
    func hasMinimumLength(password: String) -> Bool
    func hasCapitalLetter(password: String) -> Bool
    func hasDigit(password: String) -> Bool
    func hasSpecialCharacters(password: String) -> Bool
    func checkPasswords(password: String, confirmpassword: String)
    func initScreenLocker()
}
