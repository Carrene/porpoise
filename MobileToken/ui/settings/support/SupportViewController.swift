import UIKit

class SupportViewController: BaseViewController,SupportTableViewAdapterProtocol {
    
    @IBOutlet var tableView: UITableView!
    var adapter : SupportTableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    func initUIComponents() {
        initTableView()
    }
    
    func initListeners() {
        
    }
    
    func initTableView() {
        tableView?.register(UINib(nibName:R.nib.supportTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseSupportTableViewCell.identifier)
        adapter = SupportTableViewAdapter(sender: self)
        adapter?.setDelegate(supportTableViewAdapterProtocol: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.tableFooterView = UIView()
    }

    func selectedRow() {
        
    }
    
    
}
