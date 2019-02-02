

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
//        cell.lmgLogo.image = UIImage(named: banks![indexPath.row].logoResourceId!)
        
        if selectedIndex == indexPath.row {
            cell.lbBankName.textColor = R.color.buttonColor()
            cell.isSelected = true
            bankPagerViewDelegate?.selectedBank(bankIndex: selectedIndex)
            if banks![indexPath.row].name! == "آینده" {
                cell.vCell.backgroundColor = R.color.secondaryDark()
                cell.vCell.layer.borderColor = R.color.secondaryDark()?.cgColor
                cell.lmgLogo.image = R.image.lightBankAyandehLogo()
            }
            else {
                cell.vCell.backgroundColor = R.color.secondary()
                cell.vCell.layer.borderColor = R.color.secondary()?.cgColor
                cell.lmgLogo.image = R.image.lightBankSaderatLogo()
            }
        }
        else {
            cell.vCell.backgroundColor = .clear
            cell.isSelected = false
            if banks![indexPath.row].name! == "آینده" {
                cell.lbBankName.textColor = R.color.secondaryDark()
                cell.vCell.layer.borderColor = R.color.secondaryDark()?.cgColor
                cell.lmgLogo.image = R.image.colorBankAyandehLogo()
            }
            else {
                cell.lbBankName.textColor = R.color.secondary()
                cell.vCell.layer.borderColor = R.color.secondary()?.cgColor
                cell.lmgLogo.image = R.image.bankSaderatLogo()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        bankPagerViewDelegate?.selectedBank(bankIndex: self.selectedIndex)
        collectionView.reloadData()
    }
}
