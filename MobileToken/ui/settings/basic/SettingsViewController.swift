import UIKit

class SettingsViewController: UIViewController,SettingsTableAdapterProtocol,SettingViewProtocol {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var labelVersion: UILabel!
    var adapter : SettingsTableViewAdapter?
    var settingPresenter:SettingPresenterProtocol?
    var settingMediator:SettingMediator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPresenter = SettingPresenter(settingView: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTableView()
        getVersion()
        settingPresenter?.getAllDataSetting()
        // = setingview.getsetingmediator
    }
    
    func getVersion() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        labelVersion.text =  R.string.localizable.lb_version() + " " + version!
    }
    
    func initTableView() {
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
    
    func getSettingMediator(settingMediator: SettingMediator) {
        adapter?.setSettingMediator(settingMediator: settingMediator)
        self.settingMediator = settingMediator
    }

    func selectedSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    func updateLockTimer(lockTimer: Int) {
        settingPresenter?.updateSetting(setting: Setting(lockTimer: lockTimer))
        settingMediator?.setSetting(setting: Setting(lockTimer: lockTimer))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    func changeAuthentication() {
        
    }
    

}
