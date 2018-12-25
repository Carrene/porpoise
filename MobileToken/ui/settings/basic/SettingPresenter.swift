import Foundation

class SettingPresenter:SettingPresenterProtocol {
    
    var settingMediator : SettingMediator?
    unowned let settingView : SettingViewProtocol
    
    required init(settingView:SettingViewProtocol) {
        self.settingView = settingView
    }
    
    func getAllDataSetting() {
        settingMediator = SettingMediator(setting: <#T##Setting#>, authentication: <#T##Authentication#>)
        
    }
    
    func updateSetting(setting: Setting) {
        
    }
    
    func getAuthentication() {
        let authenticationRepository = AuthenticationRealmRepository()
        let onDataResponse: ((RepositoryResponse<Authentication>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                UIHelper.showFailedSnackBar()
            } else {
                if let authentication = repoResponse.value, !authentication.isLocked {
                    if authentication.authenticationType == AuthenticationTypeEnum.PASSWORD {
                        //self?.authenticationView.setAuthentication(label: R.string.localizable.lb_enter_password())
                        //self?.authenticationView.embedVCPassword(authentication:repoResponse.value!)
                    } else {
                        //self?.authenticationView.setAuthentication(label: R.string.localizable.lb_enter_pattern())
                        //self?.authenticationView.embedVCPattern(authentication: repoResponse.value!)
                    }
                } else {
                    //self?.authenticationView.navigateToLockView()
                }
            }
        }
        authenticationRepository.get(onDone: onDataResponse)
    }
    
    func getSetting() {
        let settingRepository = SettingRealmRepository()
        let onDataResponse: ((RepositoryResponse<Setting>) -> ()) = {[weak self] repoResponse in
            if let error = repoResponse.error {
                UIHelper.showFailedSnackBar()
            } else {
                if let setting = repoResponse.value {
                    
                } else {
                    
                }
            }
        }
        settingRepository.get(onDone: onDataResponse)
    }
    
    
}
