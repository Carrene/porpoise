import Foundation
import UIKit

class ScreenLocker: NSObject{
    
    static let instance : ScreenLocker = {
        
        let instance = ScreenLocker()
        return instance
    }()
    
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
    
    func lockScreen() {
        UserDefaults.standard.set(true, forKey: "locked")
        let vc = R.storyboard.authentication.authenticationViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func resetTimer(time:Int){
        
        if(self.timer != nil){
            self.time = time
            self.timer.invalidate()
            self.timer = nil
            start()
        }
    }
}

