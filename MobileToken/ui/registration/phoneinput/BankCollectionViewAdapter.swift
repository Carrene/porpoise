

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
        
        if banks![indexPath.row].name! == "آینده" {
            cell.lmgLogo.image = R.image.bankAyandehLogo()
        }
        else {
            cell.lmgLogo.image = R.image.bankSaderatLogo()
        }
        
        if selectedIndex == indexPath.row {
            cell.isSelected = true
            bankPagerViewDelegate?.selectedBank(bankIndex: selectedIndex)
            cell.vCell.layer.borderColor = R.color.secondary()?.cgColor
        }
        else {
            cell.isSelected = false
            cell.vCell.layer.borderColor = R.color.primaryDark()?.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        bankPagerViewDelegate?.selectedBank(bankIndex: self.selectedIndex)
        collectionView.reloadData()
        
    }
}
