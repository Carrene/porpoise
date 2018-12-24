

import Foundation
import UIKit

protocol SettingsTableAdapterProtocol {
    func selectedSegue(identifier:String)
}

class SettingsTableViewAdapter:NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var settingTableAdapterProtocol : SettingsTableAdapterProtocol?
    var sender:SettingsViewController?
    var settingMediator : SettingMediator?
    
    func setDelegate(settingTableAdapterProtocol:SettingsTableAdapterProtocol) {
        self.settingTableAdapterProtocol = settingTableAdapterProtocol
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    init(sender:SettingsViewController) {
        self.sender = sender
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseLockScreenTimerSettingRow.identifier, for: indexPath) as! LockScreenTimeSettingTableViewCell
            
            if let lockTimer = settingMediator?.getSetting().lockTimer {
                (cell as! LockScreenTimeSettingTableViewCell).labelSecond.text = "\(lockTimer)"
            } else {
                //(cell as! LockScreenTimeSettingTableViewCell).labelSecond.text = "60"
            }
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier, for: indexPath) as! AuthenticationTypeSettingTableViewCell
            (cell as! AuthenticationTypeSettingTableViewCell).labelType.text = settingMediator?.getAuthentication().AuthenticationType
        default:
            break
        }
        return cell
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
    }
    
}
