
import Foundation
import UIKit

class BankCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var vCell: UIView!
    @IBOutlet weak var lbBankName: UILabel!
    @IBOutlet weak var lmgLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vCell.layer.cornerRadius = 10
        vCell.layer.borderColor = R.color.secondaryDark()?.cgColor
        vCell.layer.borderWidth = 2
        lbBankName.font = R.font.iranSansMobileBold(size: 16)
    }
}
