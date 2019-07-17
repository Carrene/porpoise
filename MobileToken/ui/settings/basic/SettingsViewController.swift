import UIKit


class SettingsViewController: UIViewController,SettingsTableAdapterProtocol,SettingViewProtocol {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var labelVersion: UILabel!
    var adapter : SettingsTableViewAdapter?
    var settingPresenter:SettingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPresenter = SettingPresenter(settingView: self)
        settingPresenter?.getAllDataSetting()
        getVersion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func getVersion() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        labelVersion.text = version!
    }
    
    func initTableView(settingMediator: SettingMediator) {
        tableView?.register(UINib(nibName:R.nib.lockScreenTimeTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseLockScreenTimerSettingRow.identifier)
        tableView?.register(UINib(nibName:R.nib.authenticationTypeTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier)
        tableView?.register(UINib(nibName: R.nib.otpEyeSettingTableViewCell.name, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.reuseEyeSettingTableViewCell.identifier)
        adapter = SettingsTableViewAdapter()
        adapter!.setDelegate(settingTableAdapterProtocol: self)
        adapter?.setSettingMediator(settingMediator: settingMediator)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = R.color.primary()
        tableView.reloadData()
    }
    
    func setSettingMediator(settingMediator: SettingMediator) {
        initTableView(settingMediator: settingMediator)
    }
    
    func selectedSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    func updateLockTimer(setting: Setting) {
        settingPresenter?.updateSetting(setting: setting)
    }
    
    func updateShowOTP(setting: Setting) {
        settingPresenter?.updateSetting(setting: setting)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func changeAuthentication() {
        
    }
}
