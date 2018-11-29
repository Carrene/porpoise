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
    @IBOutlet var collectionButtonsTime: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewButtons.layer.cornerRadius = 5
        for index in collectionButtonsTime.indices {
            collectionButtonsTime[index].layer.cornerRadius = 10
            collectionButtonsTime[index].layer.borderWidth = 2
            collectionButtonsTime[index].layer.borderColor = R.color.buttonColor()?.cgColor
            collectionButtonsTime[index].backgroundColor = R.color.primaryDark()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
