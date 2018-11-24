//
//  BankPagerViewCell.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/23/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import UIKit

class BankCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var vCell: UIView!
    @IBOutlet weak var lbBankName: UILabel!
    @IBOutlet weak var lmgLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vCell.layer.cornerRadius = 10
        vCell.layer.borderColor = R.color.ayandehColor()?.cgColor
        vCell.layer.borderWidth = 2
        lbBankName.font = R.font.iranSansMobileBold(size: 16)
    }
}
