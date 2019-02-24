import XLActionController
import UIKit
import FSPagerView
import PopupDialog

class CardListViewController: BaseViewController,CardListViewProtocol,CardPagerViewDelegate, ImportToeknDelegate {

    
    @IBOutlet weak var vScroll: UIScrollView!
    @IBOutlet var labelFirstRegister: UILabel!
    
    private var fsPagerAdapterList = [CardPagerViewAdapter]()
    private var fsPagerCollectionView = [FSPagerView]()
    private var cardListPresenter : CardListPresenterProtocol?
    private var banks : [Bank]?
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
    
    func initUIComponents() {
        labelFirstRegister.isHidden = true
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
        return actionController
    }
    
    func actionButtonClicked(card: Card) {
        let actionController = initActionSheet(card: card)
        present(actionController, animated: true, completion: nil)
    }
    
    func deleteTokenAlert(card: Card) {
        
        let deleteTokensVC = DeleteTokenAlertViewController(nib: R.nib.deleteTokensAlert)
        
        let deleteTokensAlert = PopupDialog(viewController: deleteTokensVC,
                                        buttonAlignment: .horizontal,
                                        transitionStyle: .zoomIn,
                                        tapGestureDismissal: true,
                                        panGestureDismissal: false)
        deleteTokensVC.setTokenList(card:card)
        deleteTokensAlert.buttonAlignment = .horizontal
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor = R.color.primary()
        dialogAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        dialogAppearance.titleColor = R.color.buttonColor()
        
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.backgroundColor = R.color.primary()
        containerAppearance.cornerRadius = 10
        
        let cancelButton = CancelButton(title: R.string.localizable.cancel()) {
            
        }
        
        let saveButton = DefaultButton(title: R.string.localizable.ash_delete_token(), dismissOnTap: true) {
            self.deleteTokens(card: card, view: deleteTokensVC)        }
        
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        cancelButtonAppearance.titleColor = R.color.secondary()
        cancelButtonAppearance.separatorColor = UIColor(white: 0.9, alpha: 0.1)
        cancelButtonAppearance.buttonColor = R.color.primaryDark()
        
        let defaultButtonAppearance = DefaultButton.appearance()
        defaultButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        defaultButtonAppearance.titleColor = R.color.primary()
        defaultButtonAppearance.buttonColor = R.color.secondary()
        defaultButtonAppearance.separatorColor = UIColor(white: 0.9, alpha: 0.1)
        
        deleteTokensAlert.addButtons([saveButton, cancelButton])
        
        self.present(deleteTokensAlert, animated: true, completion: nil)
        
    }
    
    func deleteTokens(card: Card,view:DeleteTokenAlertViewController) {
        var tokens = [Token]()
        if view.buttonFirstToken?.isSelected == true {
            let token = card.TokenList.filter{$0.cryptoModuleId == Token.CryptoModuleId.one}.first
            tokens.append(token!)
        }
        if view.buttonSecondToken?.isSelected == true {
            let token = card.TokenList.filter {$0.cryptoModuleId == Token.CryptoModuleId.two}.first
            tokens.append(token!)
        }
        cardListPresenter?.deleteToken(tokens: tokens)
    }
    
    
    func editCardAlert(card: Card) {
        
        let editCardNameVC = EditCardNameAlertViewController(nibName: R.nib.editCardNameAlert.name, bundle: nil)
        
        let editCardAlert = PopupDialog(viewController: editCardNameVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)

        editCardNameVC.editNameTextField.text = card.cardName
        editCardAlert.buttonAlignment = .horizontal
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor = R.color.primary()
        dialogAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        dialogAppearance.titleColor = R.color.buttonColor()
        
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.backgroundColor = R.color.primary()
        containerAppearance.cornerRadius = 10
        
        
        let cancelButton = CancelButton(title: R.string.localizable.cancel()) {
            print("You canceled the dialog.")
        }
        
        let saveButton = DefaultButton(title: R.string.localizable.save(), dismissOnTap: true) {
            if let newCardName = editCardNameVC.editNameTextField.text {
                let cardForEdit = card
                cardForEdit.cardName = newCardName
                self.cardListPresenter?.editCard(card: card)

            }
        }
        
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        cancelButtonAppearance.titleColor = R.color.secondary()
        cancelButtonAppearance.separatorColor = UIColor(white: 0.9, alpha: 0.1)
        cancelButtonAppearance.buttonColor = R.color.primaryDark()
        
        let defaultButtonAppearance = DefaultButton.appearance()
        defaultButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        defaultButtonAppearance.titleColor = R.color.primary()
        defaultButtonAppearance.separatorColor = UIColor(white: 0.9, alpha: 0.1)
        defaultButtonAppearance.buttonColor = R.color.secondary()
        
        editCardAlert.addButtons([saveButton, cancelButton])
        
        self.present(editCardAlert, animated: true, completion: nil)
        
    }
    
    func deleteCardAlert(card: Card) {
        let deleteCardAlert = PopupDialog(title: R.string.localizable.lb_are_you_sure(), message: "")
        deleteCardAlert.transitionStyle = .zoomIn
        deleteCardAlert.buttonAlignment = .horizontal
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor = R.color.primary()
        dialogAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        dialogAppearance.titleColor = R.color.buttonColor()
        
        let containerAppearance = PopupDialogContainerView.appearance()
        //containerAppearance.backgroundColor = R.color.primaryLight()
        containerAppearance.cornerRadius = 10
        
        let cancelButton = CancelButton(title: R.string.localizable.cancel()) {
            
        }
        
        let deleteButton = DefaultButton(title: R.string.localizable.delete_card(), dismissOnTap: true) {
            self.cardListPresenter?.deleteCard(card: card)
        }
        
        var cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        cancelButtonAppearance.titleColor = R.color.secondary()
        cancelButtonAppearance.separatorColor = UIColor(white: 0.9, alpha: 0.1)
        cancelButtonAppearance.buttonColor = R.color.primaryDark()
        
        var defaultButtonAppearance = DefaultButton.appearance()
        defaultButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        defaultButtonAppearance.titleColor = R.color.primary()
        defaultButtonAppearance.separatorColor = UIColor(white: 0.9, alpha: 0.1)
        defaultButtonAppearance.backgroundColor = R.color.secondary()
        defaultButtonAppearance.buttonColor = R.color.secondary()
        
        deleteCardAlert.addButtons([deleteButton, cancelButton])
        
        self.present(deleteCardAlert, animated: true, completion: nil)
      
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
                fsPagerCollectionView[i].itemSize = CGSize(width: 300, height: 251)
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
