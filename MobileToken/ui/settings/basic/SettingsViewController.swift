//
//  SettingsViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/7/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,SettingsTableAdapterProtocol {

    @IBOutlet var tableView: UITableView!
    var adapter : SettingsTableViewAdapter?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTableView()
    }
    
    func initTableView() {
        tableView?.register(UINib(nibName:R.nib.sendSmsSettingTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseSendSmsSettingRow.identifier)
        tableView?.register(UINib(nibName:R.nib.lockScreenTimeTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseLockScreenTimerSettingRow.identifier)
        tableView?.register(UINib(nibName:R.nib.authenticationTypeTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier)
        adapter = SettingsTableViewAdapter(sender: self)
        adapter!.setDelegate(settingTableAdapterProtocol: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = R.color.primary()
        tableView.reloadData()
        
    }

    func selectedSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }

}
