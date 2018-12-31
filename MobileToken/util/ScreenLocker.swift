
import Foundation
import UIKit

class ScreenLocker {
    static let instance = ScreenLocker()
    private init() {
    }
    
    static var SCREEN_LOCKER_TIME = 6000000
    var timer:Timer!
    var time:Int!
    
    func _init(time:Int){
        
        self.time = time
    }
    
    func isRunning()->Bool{
        return timer != nil
    }
    
    func start(){
        
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.time), target: self, selector: #selector(ScreenLocker.stop), userInfo: nil, repeats: false)
    }
    
    @objc func stop(){
        
        if(self.timer != nil){
            self.timer.invalidate()
            lockScreen()
        }
    }
    
    func resetTimer(time:Int) {
        if(self.timer != nil){
            self.time = time
            self.timer.invalidate()
            self.timer = nil
            start()
        }
    }
    
    func lockScreen() {
        let vc = R.storyboard.authentication.authenticationViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
//    func getAuthentication() {
//        let authenticationRestRepository = AuthenticationRealmRepository()
//        let onDataResponse: ((RepositoryResponse<Authentication>) -> ())  = {[weak self] repoResponse in
//            if repoResponse.error != nil {
//                self?.presentAuthenticationDefinition()
//            } else {
//                if repoResponse.value != nil {
//                    self?.presentAuthentication()
//                } else {
//                    self?.presentAuthenticationDefinition()
//                }
//            }
//        }
//        authenticationRestRepository.get(onDone: onDataResponse)
//    }
//    
//    func presentAuthentication() {
//       let vc = R.storyboard.authentication.authenticationViewController()
//        UIApplication.shared.keyWindow?.rootViewController = vc
//    }
//    
//    func presentAuthenticationDefinition() {
//        let vc = R.storyboard.authenticationDefinition.authenticationDefinitionViewController()
//        UIApplication.shared.keyWindow?.rootViewController = vc
//    }
}
