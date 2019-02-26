import Foundation
protocol AuthenticationPasswordViewProtocol: class {
    func showWrongPasswordError(remainAttemps:Int)
    func navigateToCardList()
    func navigateToInputPhoneNumber()
    func navigateToLockView()
}

protocol AuthenticationPasswordPresenterProtocol {
    init(authenticationPasswordView: AuthenticationPasswordViewProtocol)
    func checkPasswordCorrection(password: String)
    func getAuthentication()
    func updateAuthentication(authentication: Authentication)
    func getAllUsers()
}


