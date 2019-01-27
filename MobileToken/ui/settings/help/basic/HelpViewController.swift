import UIKit

class HelpViewController: BaseViewController {
   
    @IBOutlet var tableView: UITableView!
    private var adapter : HelpTableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func initUIComponents() {
        initTableView()
    }
    
    func initListeners() {
        
    }
    
    func initTableView() {
//        tableView?.register(UINib(nibName:R.nib.lockScreenTimeTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseLockScreenTimerSettingRow.identifier)
//        tableView?.register(UINib(nibName:R.nib.authenticationTypeTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseAuthenticationTypeSettingRow.identifier)
        self.adapter = HelpTableViewAdapter(sender: self)
        //adapter!.setDelegate(settingTableAdapterProtocol: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = R.color.primary()
        tableView.reloadData()
    }
    
}
