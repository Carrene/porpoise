import Foundation
import Foundation
import UIKit

protocol BankCollectionViewDelegate {
    func selectedBank(bankIndex: Int?)
}

class BankCollectionViewAdapter:NSObject,UICollectionViewDataSource,UICollectionViewDelegate  {
    
    var bankPagerViewDelegate: BankCollectionViewDelegate?
    var selectedIndex: Int?
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
        if (banks?.count)! > 3 {
            collectionView.bounces = true
        }
        else {
            collectionView.bounces = false
        }
        cell.lbBankName.text = BankUtil.getName(bank: banks![indexPath.row])
        
        if banks![indexPath.row].id == 2 {
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
            cell.vCell.layer.borderColor = R.color.primary()?.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        bankPagerViewDelegate?.selectedBank(bankIndex: self.selectedIndex)
        collectionView.reloadData()
        
    }
}
