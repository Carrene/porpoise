import Foundation

protocol PhoneConfirmationViewProtocol:class {
    
    func showBadRequestError()
    func showSSMNotAvailable()
    func segue()
    func showTimer()
    func setCounterTitleToResend()
    func setCounterTitleTime(time:String)
}

protocol PhoneConfirmationPresenterProtocol {
    
    init(view:PhoneConfirmationViewProtocol)
    func bind(phone:String,activationCode:String)
    func initCodeTimer()
    func invalidateTimer()
}
