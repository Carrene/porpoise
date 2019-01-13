
import Foundation
import FSPagerView

protocol CardPagerViewDelegate {
    func selectedCard(cardIndex: Int)
}
class CardPagerViewAdapter:NSObject, FSPagerViewDelegate, FSPagerViewDataSource {
    
    var cardPagerViewDelegate: CardPagerViewDelegate?
    var selectedIndex = 0
    var bank = Bank()
    
    func setDelegate(cardPagerViewDelegate: CardPagerViewDelegate) {
        self.cardPagerViewDelegate = cardPagerViewDelegate
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if let cardCount = bank.cardList?.count {
            return cardCount + 1
        }
        else {
            return 1
        }
    }
    
    init(sender:Bank) {
        self.bank = sender
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if index == 0 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.addCardPagerViewCell.identifier, at: index) as! AddCardPagerViewCell
            cell.viewCard.labelBankName.text = self.bank.name

            //cell.viewCard.imageLogo.image = UIImage(named: self.bank.logoResourceId!)
            return cell
        }  else {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.bankCardPagerViewCell.identifier, at: index) as! BankCardPagerViewCell
            cell.vCard.imagePlus.isHidden = true
            cell.vCard.labelBankName.text = self.bank.name
            //cell.vCard.imageLogo.image = UIImage(named: self.bank.logoResourceId!)
            return cell
        }
    }
    
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
}
