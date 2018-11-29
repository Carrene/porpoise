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
    func selectedBank(bankIndex: Int)
}

class BankCollectionViewAdapter:NSObject,UICollectionViewDataSource,UICollectionViewDelegate  {
    
    var bankPagerViewDelegate: BankCollectionViewDelegate?
    var selectedIndex = 0
    var banks : [Bank]?
    
    func setDelegate(bankPagerViewDelegate: BankCollectionViewDelegate) {
        self.bankPagerViewDelegate = bankPagerViewDelegate
    }
    
    func setDataSource(banks:[Bank]){
        self.banks = banks
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (banks?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.allowsMultipleSelection = false
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.bankCollectionViewCell.identifier, for: indexPath) as! BankCollectionViewCell
        cell.lbBankName.text = banks![indexPath.row].name!
        if selectedIndex == indexPath.row {
            cell.lbBankName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.vCell.backgroundColor = R.color.ayandehColor()
        }
        else {
            cell.lbBankName.textColor = R.color.ayandehColor()
            cell.vCell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}
