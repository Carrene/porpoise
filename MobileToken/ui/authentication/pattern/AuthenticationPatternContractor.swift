import Foundation
protocol AuthenticationPatternViewProtocol: class {
    func showWrongPatternError(remainAttemps:Int)
    func navigateToCardList()
    func navigateToInputPhoneNumber()
    func navigateToLockView()
}

protocol AuthenticationPatternPresenterProtocol {
    init(authenticationPatternView: AuthenticationPatternViewProtocol)
    func checkPatternCorrection(pattern: String)
    func getAuthentication()
    func updateAuthentication(authentication: Authentication)
    func getAllUsers()
}
