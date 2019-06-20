import UIKit

class HelpViewController: BaseViewController,HelpTableAdapterProtocol {
    
    
    @IBOutlet var tableView: UITableView!
    private var adapter : HelpTableViewAdapter?
    private var index : Int?
    private var dataSource = [R.string.localizable.help_add_bank(),R.string.localizable.help_add_card(),R.string.localizable.help_edit_cardName(),R.string.localizable.help_delete_card(),R.string.localizable.help_get_token(),R.string.localizable.help_add_token(),R.string.localizable.help_change_token(),R.string.localizable.help_custom_token(),R.string.localizable.help_copy_token(),R.string.localizable.help_delete_token(),R.string.localizable.help_edit_phone()]
    
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
        self.adapter = HelpTableViewAdapter(sender: self)
        self.adapter?.setDelegate(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        self.adapter?.setDataSource(dataSource: self.dataSource)
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = R.color.primary()
        tableView.reloadData()
    }
    
    func selectedRow(index:Int) {
        self.index = index
        performSegue(withIdentifier: R.segue.helpViewController.helpToWebView, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.helpViewController.helpToWebView.identifier {
            (segue.destination as! QuestionViewController).setIndex(index:self.index!)
        }
    }
    
    
    
}
