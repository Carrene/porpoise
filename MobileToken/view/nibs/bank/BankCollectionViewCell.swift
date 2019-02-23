
import Foundation
import UIKit

class BankCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var vCell: UIView!
    @IBOutlet weak var lbBankName: UILabel!
    @IBOutlet weak var lmgLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vCell.layer.cornerRadius = 10
        vCell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        vCell.layer.shadowRadius = 3
        vCell.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        vCell.layer.shadowOpacity = 0.2
        vCell.layer.backgroundColor = R.color.primaryLight()?.cgColor
        vCell.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.15).cgColor
        lbBankName.font = R.font.iranSansMobileBold(size: 16)
    }
}
