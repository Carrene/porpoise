
import UIKit

class LatestUpdatesViewController: UIViewController {

    @IBOutlet var buttonEnterProgram: UIButton!
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
        // Do any additional setup after loading the view.
    }
    
    func initUIComponent() {
        buttonEnterProgram.layer.cornerRadius = 10
    }

}
