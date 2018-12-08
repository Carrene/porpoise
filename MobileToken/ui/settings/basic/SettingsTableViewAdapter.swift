//
//  SettingsTableViewAdapter.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/7/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsTableAdapterProtocol {
    func selectedSegue(identifier:String)
}

class SettingsTableViewAdapter:NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var settingTableAdapterProtocol : SettingsTableAdapterProtocol?
    var sender:SettingsViewController?
    
    func setDelegate(settingTableAdapterProtocol:SettingsTableAdapterProtocol) {
        self.settingTableAdapterProtocol = settingTableAdapterProtocol
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier, for: indexPath) as! AuthenticationTypeSettingTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseSendSmsSettingRow.identifier, for: indexPath) as! SendSmsSettingTableViewCell
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