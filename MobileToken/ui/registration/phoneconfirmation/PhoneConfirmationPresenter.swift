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
    
    func bind(user:User) {
        self.view.startBarIndicator()
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            let statusCode = response.restDataResponse?.response?.statusCode
            self?.view.EndBarIndicator()
            switch statusCode {
            case 200:
                let responseUser = response.value
                user.bank?.secret = responseUser!.bank?.secret
                self?.updateUserInRealm(user: user)
                self?.invalidateTimer()
            case 400:
                self?.view.showBadRequestError()
            case 801:
                self?.view.showSSMNotAvailable()
            case 500:
                self?.view.showServerError()
            case 502:
                self?.view.showNetworkError()
            default:
                UIHelper.showFailedSnackBar()
            }
        }
        userRepository.bind(user: user, onDone: onDataResponse)
    }
    
    func updateUserInRealm(user:User) {
        let userRealmRepository = UserRealmRepository()
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                print("\(error)")
            } else {
                self?.view.segue()
            }
        }
        userRealmRepository.update(user, onDone: onDataResponse)
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
