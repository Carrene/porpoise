import Foundation
import UIKit

protocol SettingsTableAdapterProtocol {
    func changeAuthentication()
    func selectedSegue(identifier:String)
    func updateLockTimer(setting:Setting)
}

class SettingsTableViewAdapter:NSObject,UITableViewDelegate,UITableViewDataSource,LockScreenTimeSettingTableViewCellProtocol {
    
    var settingTableAdapterProtocol : SettingsTableAdapterProtocol?
    var settingMediator : SettingMediator?
    
    func setDelegate(settingTableAdapterProtocol:SettingsTableAdapterProtocol) {
        self.settingTableAdapterProtocol = settingTableAdapterProtocol
    }
    
    func setSettingMediator(settingMediator:SettingMediator) {
        self.settingMediator = settingMediator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func updateLockTimer(lockTimer: Int) {
        self.settingMediator?.getSetting().lockTimer = lockTimer
        self.settingTableAdapterProtocol?.updateLockTimer(setting: (self.settingMediator?.getSetting())!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseLockScreenTimerSettingRow.identifier, for: indexPath) as! LockScreenTimeSettingTableViewCell
            cell.setDelegate(lockScreenTimeProtocol: self)
            let lockTimer = settingMediator?.getSetting().lockTimer
            cell.labelSecond.text = " \(lockTimer!) " + R.string.localizable.lb_seconds()
            cell.selectedLockTime(timeInterval: lockTimer!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier, for: indexPath) as! AuthenticationTypeSettingTableViewCell
            
            if settingMediator?.getAuthentication().AuthenticationType == "pattern" {
                cell.labelType.text = R.string.localizable.lb_pattern()
            } else {
                cell.labelType.text = R.string.localizable.lb_password()
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier, for: indexPath) as! AuthenticationTypeSettingTableViewCell
            cell.labelTitle!.text = R.string.localizable.lb_app_guide()
            cell.imageIcon.image = R.image.help()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier, for: indexPath) as! AuthenticationTypeSettingTableViewCell
            cell.labelTitle!.text = R.string.localizable.lb_support()
            cell.imageIcon.image = R.image.support()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat?
        switch indexPath.row {
        case 0:
            height = 150
        default:
            height = 56
        }
        return height!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            settingTableAdapterProtocol?.selectedSegue(identifier: R.segue.settingsViewController.settingToAuthenticationDefinitionSegue.identifier)
        }
        else if indexPath.row == 2 {
            settingTableAdapterProtocol?.selectedSegue(identifier: R.segue.settingsViewController.settingToHelp.identifier)
        }
        else if indexPath.row == 3 {
            settingTableAdapterProtocol?.selectedSegue(identifier: R.segue.settingsViewController.settingToSupport.identifier)
        }
    }
}
