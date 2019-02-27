import Foundation

protocol PhoneConfirmationViewProtocol:class {
    
    func showBadRequestError()
    func showSSMNotAvailable()
    func showServerError()
    func segue()
    func showTimer()
    func setCounterTitleToResend()
    func setCounterTitleTime(time:String)
    func showNetworkError()
    func startBarIndicator()
    func EndBarIndicator()
}

protocol PhoneConfirmationPresenterProtocol {
    
    init(view:PhoneConfirmationViewProtocol)
    func bind(user:User)
    func initCodeTimer()
    func invalidateTimer()
}
