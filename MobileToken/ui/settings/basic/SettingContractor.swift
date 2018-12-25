import Foundation

protocol SettingViewProtocol : class {
    func getSettingMediator(settingMediator:SettingMediator)
}

protocol SettingPresenterProtocol {
    init(settingView:SettingViewProtocol)
    func getAllDataSetting()
    func updateSetting(setting:Setting)
}
