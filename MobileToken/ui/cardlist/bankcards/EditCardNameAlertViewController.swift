import UIKit

class EditCardNameAlertViewController: UIViewController {

    @IBOutlet var editNameTextField: UITextField!
    @IBOutlet var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editNameTextField.layer.borderColor = R.color.secondary()?.cgColor
        editNameTextField.layer.borderWidth = 2
        editNameTextField.layer.cornerRadius = 5
        label.font = R.font.iranSansMobile(size: 12)
        
    }
    

}
