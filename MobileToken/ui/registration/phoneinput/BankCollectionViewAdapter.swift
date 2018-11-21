//
//  BankPagerViewAdapter.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/23/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import Foundation
import UIKit

protocol BankCollectionViewDelegate {
    func selectedCard(bankIndex: Int)
}

class BankCollectionViewAdapter:NSObject,UICollectionViewDataSource,UICollectionViewDelegate  {
    
    var bankPagerViewDelegate: BankCollectionViewDelegate?
    var selectedIndex = 0
    var banks : [Bank]?
    
    func setDelegate(bankPagerViewDelegate: BankCollectionViewDelegate) {
        self.bankPagerViewDelegate = bankPagerViewDelegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banks?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.allowsMultipleSelection = false
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.bankCollectionViewCell.identifier, for: indexPath) as! BankCollectionViewCell
        cell.vCell.layer.cornerRadius = 10
        cell.vCell.layer.borderColor = R.color.ayandehColor()?.cgColor
        cell.vCell.layer.borderWidth = 2
        cell.lbBankName.font = R.font.iranSansMobileBold(size: 16)
        if selectedIndex == indexPath.row {
            cell.vCell.backgroundColor = R.color.ayandehColor()
            cell.lbBankName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else {
            cell.vCell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       self.selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}
