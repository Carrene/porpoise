import Foundation

class SettingPresenter:SettingPresenterProtocol {

    var settingMediator : SettingMediator?
    unowned let settingView : SettingViewProtocol
    var setting:Setting?
    var authentication:Authentication?
    
    required init(settingView:SettingViewProtocol) {
        self.settingView = settingView
    }
    
    func getAllDataSetting() {
        settingMediator = SettingMediator(setting: getSetting(), authentication: getAuthentication())
        settingView.getSettingMediator(settingMediator: settingMediator!)
    }
    
    func updateSetting(setting: Setting) {
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
        settingRepository.update(setting, onDone: onDataResponse)
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
