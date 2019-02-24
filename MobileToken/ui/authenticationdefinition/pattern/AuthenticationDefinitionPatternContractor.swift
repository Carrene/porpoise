
import Foundation
protocol AuthenticationDefinitionPatternViewProtocol: class {
    func showNotMatchError()
    func showTryForSecondTimeMessage()
    func showPatternMinPointError()
    func navigateToTabbar()
}

protocol AuthenticationDefinitionPatternPresenterProtocol {
    init(authenticationDefinitionPatternView: AuthenticationDefinitionPatternViewProtocol)
    func checkPattern(count: Int, password: String)
    
}
