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
    @IBOutlet var labelSecond: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewButtons.layer.cornerRadius = 5
        for buttonTime in collectionButtonsTime {
            buttonTime.layer.cornerRadius = 10
            buttonTime.layer.borderWidth = 2
            buttonTime.layer.borderColor = R.color.buttonColor()?.cgColor
            buttonTime.backgroundColor = R.color.primaryDark()
        }
    }

    @IBAction func onTimeButton(_ sender: UIButton) {
        
        for index in collectionButtonsTime.indices {
            let button  = collectionButtonsTime[index]
            if index == collectionButtonsTime.index(of: sender)
            {
                labelSecond.text =  button.currentTitle! + "" + R.string.localizable.lb_seconds()
                button.layer.backgroundColor = R.color.buttonColor()?.cgColor
                button.setTitleColor(R.color.primaryDark(), for: .normal)
            }
            else {
                button.layer.borderColor = R.color.buttonColor()?.cgColor
                button.backgroundColor = R.color.primaryDark()
                button.setTitleColor(R.color.buttonColor(), for: .normal)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
