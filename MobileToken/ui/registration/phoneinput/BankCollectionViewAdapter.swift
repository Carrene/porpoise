

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
            cell.lbBankName.textColor = R.color.buttonColor()
            cell.vCell.backgroundColor = R.color.ayandehColor()
            cell.isSelected = true
            bankPagerViewDelegate?.selectedBank(bankIndex: selectedIndex)
        }
        else {
            cell.lbBankName.textColor = R.color.ayandehColor()
            cell.vCell.backgroundColor = .clear
            cell.isSelected = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        bankPagerViewDelegate?.selectedBank(bankIndex: self.selectedIndex)
        collectionView.reloadData()
    }
}
