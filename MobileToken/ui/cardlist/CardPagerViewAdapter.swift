
import Foundation
import FSPagerView

protocol CardPagerViewDelegate {
    func selectedCard(cardIndex: Int)
}
class CardPagerViewAdapter:NSObject, FSPagerViewDelegate, FSPagerViewDataSource {
    
    var cardPagerViewDelegate: CardPagerViewDelegate?
    var selectedIndex = 0
    
    func setDelegate(cardPagerViewDelegate: CardPagerViewDelegate) {
        self.cardPagerViewDelegate = cardPagerViewDelegate
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 2
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if index == 0 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.bankCardPagerViewCell.identifier, at: index) as! BankCardPagerViewCell
            //cell.vCard.backgroundColor = R.color.primary()
            return cell
        }else {
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.addCardPagerViewCell.identifier, at: index) as! AddCardPagerViewCell
            return cell
            
        }
    }
    
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
}
