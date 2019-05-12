
import Foundation
import FSPagerView

protocol CardPagerViewDelegate {
    func selectedCard(card: Card)
    func addCard(cardName:String,selectedBank:Bank)
    func actionButtonClicked(card: Card)
    func importToken(card: Card, cryptoModuleId: Token.CryptoModuleId)
    func removeTimerInstance(timer: Timer)
    func saveTimerInstance(timer: Timer)
}

class CardPagerViewAdapter:NSObject, FSPagerViewDelegate, FSPagerViewDataSource, AddCardPagerViewCellProtocol, BankCardPagerViewDelegate{    

    var cardPagerViewDelegate: CardPagerViewDelegate?
    var selectedIndex = 0
    var bank = Bank()
    var cardName = R.string.localizable.lb_cardName()
    var updateCard:Card?
    
    func setDelegate(cardPagerViewDelegate: CardPagerViewDelegate) {
        self.cardPagerViewDelegate = cardPagerViewDelegate
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bank.CardList.count + 1
    }
    
    init(sender:Bank) {
        self.bank = sender
        
    }
    
    func setCardDataSource(updatedCard:Card) {
        self.updateCard = updatedCard
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if index == 0 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.addCardPagerViewCell.identifier, at: index) as! AddCardPagerViewCell
            cell.setBank(bank: self.bank)
            cell.setDelegate(addCardPagerViewCellProtocol: self)
            //cell.viewCard.imageLogo.image = UIImage(named: self.bank.logoResourceId!)
            
            return cell
        }
        else {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.bankCardPagerViewCell.identifier, at: index) as! BankCardPagerViewCell
            cell.vCard.labelBankName.text = BankUtil.getName(bank: self.bank)
            cell.vCard.labelCardName.text = self.cardName
            if bank.CardList[index-1].id == updateCard?.id {
                //pagerView.scrollToItem(at: index, animated: true)
                cell.setCardName(cardName: (updateCard?.cardName)!)
                cardPagerViewDelegate?.selectedCard(card: updateCard!)
                updateCard = nil
            }
            else {
            cell.setCardName(cardName: bank.CardList[index-1].cardName!)
            }
//            cell.vCard.setDelegate(cardCellXibProtocol: self)
            //cell.vCard.imageLogo.image = UIImage(named: self.bank.logoResourceId!)
            cell.initDefaultView()
            cell.set(card: bank.CardList[index-1])
            cell.bankCardPagerViewDelegate = self
           
            return cell
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
//        pagerView.scrollToItem(at: 1, animated: false)
    }
    
    func addCardDetail(cardName: String, selectedBank: Bank) {
        cardPagerViewDelegate?.addCard(cardName: cardName, selectedBank: selectedBank)
        self.cardName = cardName
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        if targetIndex>0 {
        cardPagerViewDelegate?.selectedCard(card:bank.CardList[targetIndex-1])
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if index>0 {
        cardPagerViewDelegate?.selectedCard(card:bank.CardList[index-1])
        }
    }
    
    func importToken(card: Card, cryptoModuleId: Token.CryptoModuleId) {
        self.cardPagerViewDelegate?.importToken(card: card, cryptoModuleId: cryptoModuleId)
    }
    
    func saveTimerInstance(timer: Timer) {
        self.cardPagerViewDelegate?.saveTimerInstance(timer: timer)
    }
    
    func removeTimerInstance(timer: Timer) {
        self.cardPagerViewDelegate?.removeTimerInstance(timer: timer)
    }

    func actionSheetButtonClicked(card: Card) {
        cardPagerViewDelegate?.actionButtonClicked(card: card)
    }
}
