
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
        viewText.layer.shadowPath = UIBezierPath(roundedRect: viewText.bounds, cornerRadius: 5).cgPath
        viewText.layer.shadowRadius = 3
        viewText.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewText.layer.shadowOpacity = 0.2
        viewText.layer.backgroundColor = R.color.primaryLight()?.cgColor
        viewText.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        
    }
    
    func initTable() {
        adapter = LatestUpdatesTableAdapter(sender: self)
        tableview.delegate = adapter
        tableview.dataSource = adapter
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = R.color.primaryLight()
        tableview.reloadData()
    }

}
