import Foundation
import UIKit

protocol SettingsTableAdapterProtocol {
    func changeAuthentication()
    func selectedSegue(identifier:String)
    func updateLockTimer(lockTimer:Int)
}

class SettingsTableViewAdapter:NSObject,UITableViewDelegate,UITableViewDataSource,LockScreenTimeSettingTableViewCellProtocol {
    
    var settingTableAdapterProtocol : SettingsTableAdapterProtocol?
    var sender:SettingsViewController?
    var settingMediator : SettingMediator?
    var lockTimer:Int?
    
    func setDelegate(settingTableAdapterProtocol:SettingsTableAdapterProtocol) {
        self.settingTableAdapterProtocol = settingTableAdapterProtocol
    }
    
    func setSettingMediator(settingMediator:SettingMediator) {
        self.settingMediator = settingMediator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    init(sender:SettingsViewController) {
        self.sender = sender
    }
    
    func updateLockTimer(lockTimer: Int) {
        self.lockTimer = lockTimer
        self.settingTableAdapterProtocol?.updateLockTimer(lockTimer: lockTimer)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseLockScreenTimerSettingRow.identifier, for: indexPath) as! LockScreenTimeSettingTableViewCell
            (cell as! LockScreenTimeSettingTableViewCell).setDelegate(lockScreenTimeProtocol: self)
            
            if let lockTimer = settingMediator?.getSetting().lockTimer {
                
                (cell as! LockScreenTimeSettingTableViewCell).labelSecond.text = " \(lockTimer) " + R.string.localizable.lb_seconds()
                
                for index in (cell as! LockScreenTimeSettingTableViewCell).collectionButtonsTime.indices {
                    let button  = (cell as! LockScreenTimeSettingTableViewCell).collectionButtonsTime[index]
                    button.isSelected = false
                    if button.currentTitle == "\(lockTimer)" {
                        (cell as! LockScreenTimeSettingTableViewCell).setSelectedIndex(selectedIndex: index)
                        button.isSelected = true
                        break
                    }
                }
                
            } else {
                //(cell as! LockScreenTimeSettingTableViewCell).labelSecond.text = "60"
            }
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier, for: indexPath) as! AuthenticationTypeSettingTableViewCell
            
            if settingMediator?.getAuthentication().AuthenticationType == "pattern" {
                (cell as! AuthenticationTypeSettingTableViewCell).labelType.text = R.string.localizable.lb_pattern()
            } else {
                (cell as! AuthenticationTypeSettingTableViewCell).labelType.text = R.string.localizable.lb_password()
            }
            
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier, for: indexPath) as! AuthenticationTypeSettingTableViewCell
            (cell as! AuthenticationTypeSettingTableViewCell).labelTitle!.text = R.string.localizable.lb_app_guide()
            (cell as! AuthenticationTypeSettingTableViewCell).imageIcon.image = R.image.help()
            //cell.accessoryType = .disclosureIndicator
            
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
        else if indexPath.row == 2 {
            settingTableAdapterProtocol?.selectedSegue(identifier: R.segue.settingsViewController.settingToHelp.identifier)
        }
    }
    
}
