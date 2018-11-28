//
//  LockScreenTimeTableViewCell.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/7/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class LockScreenTimeSettingTableViewCell: UITableViewCell {
    @IBOutlet var viewCell: UIView!
    @IBOutlet var viewButtons: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewButtons.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
