
import UIKit

class LatestUpdatesViewController: UIViewController {

    @IBOutlet var buttonEnterProgram: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
        // Do any additional setup after loading the view.
    }
    
    func initUIComponent() {
        buttonEnterProgram.layer.cornerRadius = 10
    }

}
