import XLActionController
import UIKit
import FSPagerView

class CardListViewController: BaseViewController,CardListViewProtocol,CardPagerViewDelegate, ImportToeknDelegate {

    
    @IBOutlet weak var vScroll: UIScrollView!
    @IBOutlet var labelFirstRegister: UILabel!
    
    private var fsPagerAdapterList = [CardPagerViewAdapter]()
    private var fsPagerCollectionView = [FSPagerView]()
    private var cardListPresenter : CardListPresenterProtocol?
    private var banks : [Bank]?
//    private var selectedCard:Card?
//    private var updatedCard: Card?
    private var buttonDeleteFirstToken : UIButton?
    private var buttonDeleteSecondToken : UIButton?
    private var countDownTimer = [Timer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        self.cardListPresenter = CardListPresenter(view: self)
         cardListPresenter?.getBankList()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        countDownTimer.forEach { timer in
            timer.invalidate()
        }
        countDownTimer.removeAll()
    }
    
//    override func viewDidLayoutSubviews() {
//        for i in 0 ..< fsPagerCollectionView.count {
//            fsPagerCollectionView[i].scrollToItem(at: banks![i].cardList.count, animated: false)
//        }
//    }
    
    func initUIComponents() {
        labelFirstRegister.isHidden = true
        buttonDeleteFirstToken = UIButton(frame: CGRect(x: 45, y: 50, width: 220, height: 40))
        buttonDeleteFirstToken?.layer.cornerRadius = 10
        buttonDeleteFirstToken?.layer.borderColor = R.color.buttonColor()?.cgColor
        buttonDeleteFirstToken?.backgroundColor = .clear
        buttonDeleteFirstToken?.layer.borderWidth = 1
        buttonDeleteFirstToken?.setTitle(R.string.localizable.alert_delete_first_token(), for: .normal)
        buttonDeleteFirstToken?.setTitleColor(R.color.buttonColor(), for: .normal)
        buttonDeleteFirstToken?.setTitleColor(R.color.secondary(), for: .selected)
        buttonDeleteFirstToken?.titleLabel?.font = R.font.iranSansMobileBold(size: 16)
        buttonDeleteFirstToken?.addTarget(self, action: #selector(onbuttonDeleteFirstToken), for: .touchUpInside)
        
        buttonDeleteSecondToken = UIButton(frame: CGRect(x: 45, y: 104, width: 220, height: 40))
        buttonDeleteSecondToken?.layer.cornerRadius = 10
        buttonDeleteSecondToken?.layer.borderColor = R.color.buttonColor()?.cgColor
        buttonDeleteSecondToken?.setTitleColor(R.color.buttonColor(), for: .normal)
        buttonDeleteSecondToken?.setTitleColor(R.color.secondary(), for: .selected)
        buttonDeleteSecondToken?.backgroundColor = .clear
        buttonDeleteSecondToken?.layer.borderWidth = 1
        buttonDeleteSecondToken?.setTitle(
            R.string.localizable.alert_delete_second_token(), for: .normal)
        buttonDeleteSecondToken?.titleLabel?.font = R.font.iranSansMobileBold(size: 16)
        buttonDeleteSecondToken?.addTarget(self, action: #selector(onbuttonDeleteSecondToken), for: .touchUpInside)
    }
    
    func initListeners() {
        
    }
    
    func setBankList(banks: [Bank]) {
        self.banks = banks
        initPagerList()
    }
    
    func selectedCard(card: Card) {
//        self.selectedCard = card
    }
    
    func updateCardList(card: Card) {
        for i in 0 ..< banks!.count {
            let cardList = banks![i].cardList
            for j in 0 ..< cardList.count {
                if cardList[j].id == card.id {
                    banks![i].cardList[j] = card
                    fsPagerCollectionView[i].reloadData()
                }
            }
            
        }
    }
    
    func addCard(card: Card) {
        for i in 0 ..< banks!.count {
            if card.bank?.id == banks![i].id {
                banks![i].cardList.append(card)
                fsPagerCollectionView[i].reloadData()
                fsPagerCollectionView[i].layoutIfNeeded()
                fsPagerCollectionView[i].scrollToItem(at: banks![i].cardList.count, animated: false)
            }
        }
    }
    
    func deleteCard(card: Card) {
        for i in 0 ..< banks!.count {
            if card.bank?.id == banks![i].id {
                let index = banks![i].cardList.index(where: {$0.id == card.id})
                banks![i].cardList.remove(at: index!)
                fsPagerCollectionView[i].reloadData()
                fsPagerCollectionView[i].layoutIfNeeded()
                fsPagerCollectionView[i].scrollToItem(at: index!, animated: false)
            }
        }
    }
    
    func deleteToken(tokens: [Token]) {
        for token in tokens {
            for i in 0 ..< banks!.count {
                let cards = banks![i].cardList
                for j in 0 ..< cards.count{
                    let tokenList = banks![i].cardList[j].TokenList
                    for z in 0 ..< tokenList.count {
                        if tokens.count == 2 {
                            banks![i].cardList[j].TokenList.removeAll()
                        }else if token.id == tokenList[z].id {
                            banks![i].cardList[j].TokenList.remove(at: z)
                        }
                        fsPagerCollectionView[i].reloadData()
                        fsPagerCollectionView[i].layoutIfNeeded()
                        fsPagerCollectionView[i].scrollToItem(at: j + 1, animated: false)
                    }
                }
            }
        }
        
    }
    
    func initActionSheet(card: Card) -> MobileTokenActionSheetController {
        let actionController = MobileTokenActionSheetController()
        
        let editCardAction = Action(ActionData(title: R.string.localizable.ash_edit_card_name(), image: R.image.cardEdit()!), style: .default, handler: { action in self.editCardAlert(card: card)})
        let deleteCardAction = Action(ActionData(title: R.string.localizable.ash_delete_card(), image: R.image.cardDelete()!), style: .default, handler: { action in self.deleteCardAlert(card: card)})
        var deleteTokenAction = Action(ActionData(title: R.string.localizable.ash_delete_token(), image: R.image.passDelete()!), style: .default, handler: { action in self.deleteTokenAlert(card: card)})
        if card.TokenList.count == 0 {
            deleteTokenAction.enabled = false
        }
        actionController.addAction(editCardAction)
        actionController.addAction(deleteCardAction)
        actionController.addAction(deleteTokenAction)
        buttonDeleteFirstToken?.isSelected = false
        buttonDeleteFirstToken?.layer.borderColor = R.color.buttonColor()?.cgColor
        buttonDeleteSecondToken?.isSelected = false
        buttonDeleteSecondToken?.layer.borderColor = R.color.buttonColor()?.cgColor
        return actionController
    }
    
    func actionButtonClicked(card: Card) {
        let actionController = initActionSheet(card: card)
        present(actionController, animated: true, completion: nil)
    }
    
    func deleteTokenAlert(card: Card) {
        buttonDeleteFirstToken?.isEnabled = false
        buttonDeleteSecondToken?.isEnabled = false
        card.TokenList.forEach{token in
            if token.cryptoModuleId == Token.CryptoModuleId.one {
                buttonDeleteFirstToken?.isEnabled = true
            } else if token.cryptoModuleId == Token.CryptoModuleId.two {
                buttonDeleteSecondToken?.isEnabled = true
            }
        }
        let deleteTokenAlert = UIAlertController(title: "", message:"" , preferredStyle: .alert)
        let margin:CGFloat = 10.0
        let rect = CGRect(x: margin, y: margin, width: 335, height: 170)
        let customView = UIView(frame: rect)
        
        customView.addSubview(buttonDeleteFirstToken!)
        customView.addSubview(buttonDeleteSecondToken!)
        
        let labelTitle = NSAttributedString(string: R.string.localizable.alert_choose_token(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobileBold(size: 16)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!
            ])
        
        deleteTokenAlert.view.addSubview(customView)
        deleteTokenAlert.setValue(labelTitle, forKey: "attributedMessage")
        
        let saveAction = UIAlertAction(title: R.string.localizable.ash_delete_token() , style: .default, handler: { (action : UIAlertAction!) -> Void in
            self.deleteTokens(card: card)
        })
      
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel() , style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: deleteTokenAlert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.33)
        
        deleteTokenAlert.view.addConstraint(height)
        
        let width:NSLayoutConstraint = NSLayoutConstraint(item: deleteTokenAlert.view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.width * 0.9)
        deleteTokenAlert.view.addConstraint(width)
        
        
        deleteTokenAlert.addAction(saveAction)
        deleteTokenAlert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(deleteTokenAlert, animated: true, completion:{})
        }
        
        let subview = (deleteTokenAlert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 10
        subview.backgroundColor = R.color.primaryLight()
        
    }
    
    func deleteTokens(card: Card) {
        var tokens = [Token]()
        if buttonDeleteFirstToken?.isSelected == true {
            let token = card.TokenList.filter{$0.cryptoModuleId == Token.CryptoModuleId.one}.first
            tokens.append(token!)
        }
        if buttonDeleteSecondToken?.isSelected == true {
            let token = card.TokenList.filter {$0.cryptoModuleId == Token.CryptoModuleId.two}.first
            tokens.append(token!)
        }
        cardListPresenter?.deleteToken(tokens: tokens)
    }
    
    @objc func onbuttonDeleteFirstToken(sender: UIButton) {
        if !(buttonDeleteFirstToken?.isSelected)! {
            buttonDeleteFirstToken?.isSelected = true
            buttonDeleteFirstToken?.layer.borderColor = R.color.secondary()?.cgColor
        }
        else {
            buttonDeleteFirstToken?.isSelected = false
            buttonDeleteFirstToken?.layer.borderColor = R.color.buttonColor()?.cgColor
        }
    }
    
    @objc func onbuttonDeleteSecondToken() {
        if !(buttonDeleteSecondToken?.isSelected)! {
            buttonDeleteSecondToken?.isSelected = true
            buttonDeleteSecondToken?.layer.borderColor = R.color.secondary()?.cgColor
        }
        else {
            buttonDeleteSecondToken?.isSelected = false
            buttonDeleteSecondToken?.layer.borderColor = R.color.buttonColor()?.cgColor
        }
    }
    
    func editCardAlert(card: Card) {
        let attributedString = NSAttributedString(string: R.string.localizable.lb_add_card_name(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobile(size: 14)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!.withAlphaComponent(0.5)
            ])
        
        let editCardAlert = UIAlertController(title: "", message: R.string.localizable.lb_add_card_name() , preferredStyle: .alert)
        
        editCardAlert.addTextField { (textField : UITextField!) -> Void in
            editCardAlert.setValue(attributedString, forKey: "attributedMessage")
            
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
            textField.addConstraint(heightConstraint)
            textField.backgroundColor = R.color.primaryLight()
            textField.textColor = R.color.buttonColor()
            textField.layer.borderColor = R.color.eyeCatching()?.cgColor
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.tintColor = R.color.eyeCatching()
            textField.borderStyle = .roundedRect
            textField.keyboardAppearance = .dark
            let textView = (textField.subviews.first!)
            textView.backgroundColor = .clear
            textField.text = card.cardName

        }
        
        let saveAction = UIAlertAction(title: R.string.localizable.save() , style: .default, handler: { alert -> Void in
            if let newCardName = editCardAlert.textFields![0].text {
                let cardForEdit = card
                cardForEdit.cardName = newCardName
                self.cardListPresenter?.editCard(card: card)
                
            }
        })
        
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel() , style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        editCardAlert.addAction(saveAction)
        editCardAlert.addAction(cancelAction)
        
        
        self.present(editCardAlert, animated: true, completion: nil)
        
        let subview = (editCardAlert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 10
        subview.backgroundColor = R.color.primaryLight()
    }
    
    func deleteCardAlert(card: Card) {
        let attributedString = NSAttributedString(string: R.string.localizable.lb_are_you_sure(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobileBold(size: 16)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!
            ])
        let deleteCardAlert = UIAlertController(title: "", message:"" , preferredStyle: .alert)
        
        deleteCardAlert.setValue(attributedString, forKey: "attributedMessage")
        
        let deleteAction = UIAlertAction(title: R.string.localizable.delete_card() , style: .default , handler: { alert -> Void in
            self.cardListPresenter?.deleteCard(card: card)
        })
        
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel() , style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        deleteCardAlert.addAction(deleteAction)
        deleteCardAlert.addAction(cancelAction)
        
        
        self.present(deleteCardAlert, animated: true, completion: nil)
        
        let subview = (deleteCardAlert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 10
        subview.backgroundColor = R.color.primaryLight()
    }
    
    
    func addCard(cardName:String ,selectedBank:Bank) {
        let card = Card(number: "", cardName: cardName, cardType: Card.CardTypeEnum.BANK )
        cardListPresenter?.addCard(card: card, bank: selectedBank)
    }
    
    func reloadCardPager() {
        UIHelper.showSuccessfulSnackBar(message: R.string.localizable.sb_successfully_done())
        initCardListPagerView()
    }
    
    func initPagerList() {
        fsPagerAdapterList.removeAll()
        for i in (banks?.indices)! {
            fsPagerAdapterList.append(CardPagerViewAdapter(sender: banks![i]))
        }
        initCardListPagerView()
    }
    
    func noBank() {
        labelFirstRegister.isHidden = false
    }
    
    func initCardListPagerView() {
        var y = 0
        if fsPagerAdapterList.count > 0 {
            fsPagerCollectionView.removeAll()
            labelFirstRegister.isHidden = true
            vScroll.subviews.forEach({ $0.removeFromSuperview() })
            for i in fsPagerAdapterList.indices {
                let screenBounds =  UIScreen.main.bounds
                //TODO: Scrool view size!!! check
                let frame = CGRect(x: 0, y: y, width: Int(screenBounds.width), height: 251)
                let cardListPagerView = FSPagerView(frame: frame)
                y += 270
                fsPagerCollectionView.append(cardListPagerView)
                
                let addCardNib = UINib(resource: R.nib.addCardPagerViewCell)
                fsPagerCollectionView[i].register(addCardNib, forCellWithReuseIdentifier: R.nib.addCardPagerViewCell.identifier)
                
                let bankCardNib = UINib(resource: R.nib.bankCardPagerViewCell)
                fsPagerCollectionView[i].register(bankCardNib, forCellWithReuseIdentifier: R.nib.bankCardPagerViewCell.identifier)
                
                fsPagerAdapterList[i] = CardPagerViewAdapter(sender: banks![i])
                fsPagerAdapterList[i].setDelegate(cardPagerViewDelegate: self)
                fsPagerCollectionView[i].delegate = fsPagerAdapterList[i]
                fsPagerCollectionView[i].dataSource = fsPagerAdapterList[i]
                fsPagerCollectionView[i].itemSize = CGSize(width: 320, height: 251)
                fsPagerCollectionView[i].interitemSpacing = 10
                vScroll.isScrollEnabled = true
                vScroll.contentSize = CGSize(width: screenBounds.width, height: CGFloat(y + 40))
                vScroll.addSubview(cardListPagerView)
                fsPagerCollectionView[i].reloadData()
                fsPagerCollectionView[i].layoutIfNeeded()
                if banks![i].cardList.count > 0 {
                    fsPagerCollectionView[i].scrollToItem(at: 1, animated: false)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = (segue.destination as? ImportTokenViewController) {
            let info: (card: Card, cryptoModuleId: Token.CryptoModuleId) = sender as! (card: Card, cryptoModuleId: Token.CryptoModuleId)
            destination.setDelegate(importTokenDelegate: self)
            destination.set(card: info.card, cryptoModuleId: info.cryptoModuleId)
        }
    }
    
    func importToken(card: Card, cryptoModuleId: Token.CryptoModuleId) {
        performSegue(withIdentifier: R.segue.cardListViewController.navigateToImportToken.identifier, sender: (card:card, cryptoModuleId: cryptoModuleId))
    }
    
    func importedToken(card: Card) {
        updateCardList(card: card)
        self.navigationController?.popViewController(animated: true)
    }
    
    func removeTimerInstance(timer: Timer) {
       self.countDownTimer.remove(timer)
    }
    
    func saveTimerInstance(timer: Timer) {
        self.countDownTimer.append(timer)
    }
}
