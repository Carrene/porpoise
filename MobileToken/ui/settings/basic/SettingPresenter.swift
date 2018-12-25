import Foundation

class SettingPresenter:SettingPresenterProtocol {
    
    var settingMediator : SettingMediator?
    unowned let settingView : SettingViewProtocol
    var setting:Setting?
    var authentication:Authentication?
    
    required init(settingView:SettingViewProtocol) {
        self.settingView = settingView
    }
    
    func getAllDataSetting() -> SettingMediator {
        settingMediator = SettingMediator(setting: getSetting(), authentication: getAuthentication())
        return settingMediator!
    }
    
    func updateSetting(setting: Setting) {
        
    }
    
    func getAuthentication() -> Authentication{
        let authenticationRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if repoResponse.error != nil {
                UIHelper.showFailedSnackBar()
            } else {
                if let authentication = repoResponse.value {
                    self?.authentication = authentication
                } else {
                    UIHelper.showFailedSnackBar()
                }
            }
        }
        authenticationRepository.get(onDone: onDataResponse)
        return authentication!
    }
    
    func getSetting() -> Setting{
        let settingRepository = SettingRealmRepository()
        let onDataResponse: ((RepositoryResponse<Setting>) -> ()) = {[weak self] repoResponse in
            if repoResponse.error != nil {
                UIHelper.showFailedSnackBar()
            } else {
                if let setting = repoResponse.value {
                    self?.setting = setting
                } else {
                    UIHelper.showFailedSnackBar()
                }
            }
        }
        settingRepository.get(onDone: onDataResponse)
        return setting!
    }
    
    
}
