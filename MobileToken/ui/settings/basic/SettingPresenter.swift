import Foundation

class SettingPresenter:SettingPresenterProtocol {
    
    unowned let settingView : SettingViewProtocol
    
    required init(settingView:SettingViewProtocol) {
        self.settingView = settingView
    }
    
    func getAllDataSetting() {
        let settingMediator = SettingMediator(setting: getSetting(), authentication: getAuthentication())
        settingView.setSettingMediator(settingMediator: settingMediator)
    }
    
    func updateSetting(setting: Setting) {
        let settingRepository = SettingRealmRepository()
        let onDataResponse: ((RepositoryResponse<Setting>) -> ()) = {[weak self] repoResponse in
            if repoResponse.error != nil {
                UIHelper.showFailedSnackBar()
            } else {
                if let _ = repoResponse.value {
                    self!.getAllDataSetting()
                } else {
                    UIHelper.showFailedSnackBar()
                }
            }
        }
        settingRepository.update(setting, onDone: onDataResponse)
    }
    
    func getAuthentication() -> Authentication{
        var authentication: Authentication?
        let authenticationRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = { repoResponse in
            if repoResponse.error != nil {
                UIHelper.showFailedSnackBar()
            } else {
                if let authenticationResponse = repoResponse.value {
                    authentication = authenticationResponse
                } else {
                    UIHelper.showFailedSnackBar()
                }
            }
        }
        authenticationRepository.get(onDone: onDataResponse)
        return authentication!
    }
    
    func getSetting() -> Setting{
        var setting: Setting?
        let settingRepository = SettingRealmRepository()
        let onDataResponse: ((RepositoryResponse<Setting>) -> ()) = { repoResponse in
            if repoResponse.error != nil {
                UIHelper.showFailedSnackBar()
            } else {
                if let settingResponse = repoResponse.value {
                    setting = settingResponse
                } else {
                    UIHelper.showFailedSnackBar()
                }
            }
        }
        settingRepository.get(onDone: onDataResponse)
        return setting!
    }
}
