import Foundation

protocol SettingViewProtocol : class {
    func setSettingMediator(settingMediator:SettingMediator)
}

protocol SettingPresenterProtocol {
    init(settingView:SettingViewProtocol)
    func getAllDataSetting()
    func updateSetting(setting:Setting)
}
