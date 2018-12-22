
import UIKit

class ApplicationLockViewController: BaseViewController {

    @IBOutlet var labelDescription: UITextView!
    @IBOutlet var imageLock: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func initUIComponents() {
        labelDescription.font = R.font.iranSansMobile(size: 16)
        imageLock.layer.cornerRadius = 5
    }
    
    func initListeners() {
        
    }
    

}
