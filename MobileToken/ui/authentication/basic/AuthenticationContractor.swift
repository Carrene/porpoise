
import Foundation
protocol AuthenticationViewProtocol: AuthenticationDelegate {
    func embedVCPassword(authentication:Authentication)
    func embedVCPattern(authentication:Authentication)
    func setAuthentication(label: String)
}

protocol AuthenticationPresenterProtocol {
    init(authenticationView: AuthenticationViewProtocol)
    func getAuthentication()
}

protocol AuthenticationDelegate:class {
    func navigateToCardList()
    func navigateToInputPhoneNumber()
    func navigateToLockView()
}
