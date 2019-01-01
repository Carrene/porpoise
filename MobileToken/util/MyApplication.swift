import UIKit

@objc(MyApplication)

class MyApplication: UIApplication {
    
    override func sendEvent(_ event: UIEvent) {
        
        if event.type != .touches {
            
            super.sendEvent(event)
            return
        }
        
        var restartTimer = false
        
        if let touches = event.allTouches {
            
            for touch in touches.enumerated() {
                
                if touch.element.phase != .cancelled && touch.element.phase != .ended {
                    restartTimer = true
                    break
                }
            }
        }
        
        if restartTimer {
            if var topController = UIApplication.shared.keyWindow?.rootViewController{
                while let presentedViewController = topController.presentedViewController{
                    topController = presentedViewController
                }
                ScreenLocker.instance.resetTimer(time: ScreenLocker.SCREEN_LOCKER_TIME)
            }
        }
        super.sendEvent(event)
    }
}
