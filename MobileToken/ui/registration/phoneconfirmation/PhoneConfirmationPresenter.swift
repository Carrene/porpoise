import Foundation

class PhoneConfirmationPresenter:PhoneConfirmationPresenterProtocol {
    
    private unowned let view : PhoneConfirmationViewProtocol
   
    private var timeCount : Int!
    private static let SMS_TIMER = 2 * 60
    private var timer:Timer?
    
    required init(view: PhoneConfirmationViewProtocol) {
        self.view = view
    }
    
    func bind(user:User) {
        let userRepository = UserRepository()
        self.view.startBarIndicator()
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            self?.view.endBarIndicator()
            if let statusCode = response.restDataResponse?.response?.statusCode {
                switch statusCode {
                case 200:
                    let responseUser = response.value
                    user.bank?.secret = responseUser!.bank?.secret
                    self?.updateUserInRealm(user: user)
                    self?.invalidateTimer()
                case 400:
                    self?.view.showBadRequestError()
                case 401:
                    self?.view.showEverywhereError401()
                case 500:
                    self?.view.showServerError()
                case 502:
                    self?.view.showNetworkError()
                case 801:
                    self?.view.showSSMNotAvailable()
                default:
                    UIHelper.showFailedSnackBar()
                }
            }
                
            else {
                //self?.view.showEverywhereFail()
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
        self.timer?.fire()
    }
    
    func timeString(time:Double) -> String {
        
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        return String(format:"%02i:%02i",minutes,Int(seconds))
    }
    
    func invalidateTimer() {
        if timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
    }
    
    func claim(phone: String,bank:Bank) {
         self.view.startBarIndicator()
        let userRepository = UserRepository()
        self.view.startBarIndicator()
        let user = User(phone: phone, activationCode: nil, bank: bank)
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            if let statusCode = response.restDataResponse?.response?.statusCode {
                self?.view.endBarIndicator()
                switch statusCode {
                case 200:
                   self?.view.endBarIndicator()
                   self?.initCodeTimer()
                case 400:
                    self?.view.showBadRequestError()
                case 401:
                    self?.view.showEverywhereError401()
                case 500:
                    self?.view.showServerError()
                case 502:
                    self?.view.showNetworkError()
                default:
                    UIHelper.showFailedSnackBar()
                }
            }
            else {
                //self?.view.showEverywhereFail()
            }
        }
        userRepository.claim(user: user, onDone: onDataResponse)
    }
}
