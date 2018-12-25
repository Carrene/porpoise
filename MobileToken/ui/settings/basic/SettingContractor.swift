import Foundation

protocol SettingViewProtocol : class {
    
}

protocol SettingPresenterProtocol {
    init(settingView:SettingViewProtocol)
    func getAllDataSetting()
    func updateSetting(setting:Setting)
}
