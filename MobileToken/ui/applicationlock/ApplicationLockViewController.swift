
import UIKit

class ApplicationLockViewController: BaseViewController {

    @IBOutlet var labelDescription: UITextView!
    @IBOutlet var imageLock: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initUIComponents() {
        imageLock.layer.cornerRadius = 5
    }
    
    func initListeners() {
        
    }
    

}
