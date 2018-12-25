import UIKit

class SettingsViewController: UIViewController,SettingsTableAdapterProtocol,SettingViewProtocol {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var labelVersion: UILabel!
    var adapter : SettingsTableViewAdapter?
    var settingPresenter:SettingPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingPresenter = SettingPresenter(settingView: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTableView()
        getVersion()
        settingPresenter?.getAllDataSetting()
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
    }

    func selectedSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }

}
