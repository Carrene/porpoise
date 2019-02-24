
import Foundation
protocol SettingAuthenticationDefinitionPatternViewProtocol: class {
    func showNotMatchError()
    func showTryForSecondTimeMessage()
    func showPatternMinPointError() 
}

protocol SettingAuthenticationDefinitionPatternPresenterProtocol {
    init(authenticationDefinitionPatternView: SettingAuthenticationDefinitionPatternViewProtocol)
    func checkPattern(count: Int, password: String)
}
