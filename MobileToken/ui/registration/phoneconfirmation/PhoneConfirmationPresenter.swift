//
//  PhoneConfirmationPresenter.swift
//  
//
//  Created by Fateme' Kazemi on 8/30/1397 AP.
//

import Foundation

class PhoneConfirmationPresenter:PhoneConfirmationPresenterProtocol {
    
    unowned let view : PhoneConfirmationViewProtocol
    var userRepository = UserRepository()
    var timeCount = 30
    var timer:Timer!
    
    required init(view: PhoneConfirmationViewProtocol) {
        
        self.view = view
    }
    
    func bind(phone:String,activationCode:String) {
        
        let user = User(phone: phone, activationCode: activationCode)
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] restRepoResponse in
            let statusCode = restRepoResponse.restDataResponse?.response?.statusCode
            switch statusCode {
            case 200:
                self?.view.segue()
            case 400:
                self?.view.showBadRequestError()
            case 801:
                self?.view.showSSMNotAvailable()
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
            timeCount=timeCount-1
        }
    }
    
    func initCodeTimer() {
        
        view.setCounterTitleToResend()
        self.timeCount = 30
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
