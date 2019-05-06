
import Foundation
import UIKit

class BankCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var vCell: UIView!
    @IBOutlet weak var lbBankName: UILabel!
    @IBOutlet weak var lmgLogo: UIImageView!
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        //view.layer.borderWidth = 1
        //view.layer.borderColor = R.color.primaryLight()?.cgColor
        //view.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.8
        view.layer.backgroundColor = R.color.primaryLight()?.cgColor
        view.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        vCell.layer.borderColor = R.color.primaryLight()?.cgColor
        vCell.layer.cornerRadius = 10
        
        vCell.layer.borderWidth = 2

    }
}
