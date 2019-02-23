
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
        view.layer.borderWidth = 0
        view.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.2
        view.layer.backgroundColor = R.color.primaryLight()?.cgColor
        view.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        vCell.layer.borderColor = R.color.primaryLight()?.cgColor
        vCell.layer.cornerRadius = 10
        
//        vCell.layer.borderWidth = 1
//        vCell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
//        vCell.layer.shadowRadius = 5
//        vCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        vCell.layer.shadowOpacity = 0.2
//        vCell.layer.backgroundColor = R.color.primaryLight()?.cgColor
//        vCell.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
//        lbBankName.font = R.font.iranSansMobileBold(size: 16)
    }
}
