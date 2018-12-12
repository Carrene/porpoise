
import UIKit

class LatestUpdatesViewController: UIViewController {

    @IBOutlet var buttonEnterProgram: UIButton!
    @IBOutlet var tableview: UITableView!
    @IBOutlet var viewText: UIView!
    
    var adapter:LatestUpdatesTableAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
        initTable()
    }
    
    func initUIComponent() {
        buttonEnterProgram.layer.cornerRadius = 10
        viewText.layer.cornerRadius = 5
    }
    
    func initTable() {
        //tableview?.register(UINib(nibName:R.nib.lockScreenTimeTableViewCell.name,bundle: nil),forCellReuseIdentifier:R.reuseIdentifier.reuseLockScreenTimerSettingRow.identifier)
        //tableview.register(, forCellReuseIdentifier: <#T##String#>)
        adapter = LatestUpdatesTableAdapter(sender: self)
        tableview.delegate = adapter
        tableview.dataSource = adapter
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = R.color.primaryLight()
        tableview.reloadData()
    }

}
