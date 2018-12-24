import Foundation

class SettingMediator {
    
    private var setting : Setting?
    private var authentication : Authentication?
    
    init(setting:Setting ,  authentication:Authentication) {
        self.setting = setting
        self.authentication = authentication
    }
    
    func setSetting(setting:Setting) {
        self.setting = setting
    }
    
    func getSetting() -> Setting {
        return self.setting!
    }
    
    func getAuthentication() -> Authentication {
        return self.authentication!
    }
}
