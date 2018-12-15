import Foundation

class PhoneConfirmationPresenter:PhoneConfirmationPresenterProtocol {
    
    private unowned let view : PhoneConfirmationViewProtocol
    private var userRepository = UserRepository()
    private var timeCount : Int!
    private static let SMS_TIMER = 2 * 60
    private var timer:Timer!
    
    required init(view: PhoneConfirmationViewProtocol) {
        self.view = view
    }
    
    func bind(phone:String,activationCode:String) {
        
        let user = User(phone: phone, activationCode: activationCode)

        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            let statusCode = response.restDataResponse?.response?.statusCode
            switch statusCode {
            case 200:
                self?.view.segue()
            case 400:
                self?.view.showBadRequestError()
            case 801:
                self?.view.showSSMNotAvailable()
            case 500:
                self?.view.showServerError()
            default:
                UIHelper.showFailedSnackBar()
            }
        }
        userRepository.bind(user: user, onDone: onDataResponse)
    }
    
    @objc func update() {
        
        if(timeCount >= 0) {
            view.setCounterTitleTime(time:String(self.timeString(time: Double(timeCount))))
            if timeCount == 0 {
                view.setCounterTitleToResend()
            }
            timeCount -= 1
        }
    }
    
    func initCodeTimer() {
        
        view.setCounterTitleToResend()
        self.timeCount = PhoneConfirmationPresenter.SMS_TIMER
        self.timer = Timer.scheduledTimer(timeInterval:TimeInterval(1), target: self, selector: #selector(update), userInfo: nil, repeats: true)
        self.timer.fire()
    }
    
    func timeString(time:Double) -> String {
        
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        return String(format:"%02i:%02i",minutes,Int(seconds))
    }
    
    func invalidateTimer() {
        self.timer.invalidate()
    }
}
