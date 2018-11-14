//
//  PasswordHintTableViewCell.swift
//  alpha
//
//  Created by Fateme' Kazemi on 5/20/1397 AP.
//  Copyright © 1397 Nuesoft. All rights reserved.
//

import UIKit

class PasswordHintTableViewCell: UITableViewCell {
    @IBOutlet var lbHint: UILabel!
    @IBOutlet var imgCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }
    
}
