
import Foundation
import FSPagerView

protocol CardPagerViewDelegate {
    func selectedCard(cardIndex: Int)
    func addCard(cardName:String,selectedBank:Bank)
}

class CardPagerViewAdapter:NSObject, FSPagerViewDelegate, FSPagerViewDataSource, AddCardPagerViewCellProtocol {
   
    var cardPagerViewDelegate: CardPagerViewDelegate?
    var selectedIndex = 0
    var bank = Bank()
    var cardName = "نام کارت"
    
    func setDelegate(cardPagerViewDelegate: CardPagerViewDelegate) {
        self.cardPagerViewDelegate = cardPagerViewDelegate
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bank.cardList.count + 1
    }
    
    init(sender:Bank) {
        self.bank = sender
        print(bank.cardList.count)
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if index == 0 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.addCardPagerViewCell.identifier, at: index) as! AddCardPagerViewCell
            cell.setBank(bank: self.bank)
            cell.setDelegate(addCardPagerViewCellProtocol: self)
            
            //cell.viewCard.imageLogo.image = UIImage(named: self.bank.logoResourceId!)
            return cell
        }  else {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.bankCardPagerViewCell.identifier, at: index) as! BankCardPagerViewCell
            cell.vCard.imagePlus.isHidden = true
            cell.vCard.labelBankName.text = self.bank.name
            cell.vCard.labelCardName.text = self.cardName
            cell.setCardName(cardName: bank.cardList[index-1].cardName!)
            //cell.vCard.imageLogo.image = UIImage(named: self.bank.logoResourceId!)
            return cell
        }
    }
    
    func addCardDetail(cardName: String, selectedBank: Bank) {
        cardPagerViewDelegate?.addCard(cardName: cardName, selectedBank: selectedBank)
        self.cardName = cardName
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
}
