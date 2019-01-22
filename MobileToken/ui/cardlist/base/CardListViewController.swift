import XLActionController
import UIKit
import FSPagerView

class CardListViewController: BaseViewController,CardListViewProtocol,CardPagerViewDelegate {
   
    @IBOutlet weak var vScroll: UIScrollView!
    
    private var pagerList = [CardPagerViewAdapter]()
    private var cardListPresenter : CardListPresenterProtocol?
    let actionController = MobileTokenActionSheetController()
    private var banks : [Bank]?
    private var selectedCard:Card?
    private var updatedCard: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActionSheet()
        self.cardListPresenter = CardListPresenter(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardListPresenter?.getBankList()
    }
    
    func initUIComponents() {
        
    }
    
    func initListeners() {
        
    }
    
    func setBankList(banks: [Bank]) {
        self.banks = banks
        initPagerList()
    }
    
    func selectedCard(card: Card) {
        self.selectedCard = card
    }
    
    func updateCardList(card: Card) {
        updatedCard = card
        UIHelper.showSuccessfulSnackBar(message: R.string.localizable.sb_successfully_done())
        initPagerList()
    }
    
    func initActionSheet() {
        let editCardAction = Action(ActionData(title: R.string.localizable.ash_edit_card_name(), image: R.image.cardEdit()!), style: .default, handler: { action in self.editCardAlert()})
        let deleteCardAction = Action(ActionData(title: R.string.localizable.ash_delete_card(), image: R.image.cardDelete()!), style: .default, handler: { action in self.deleteCardAlert()})
        let deleteTokenAction = Action(ActionData(title: R.string.localizable.ash_delete_token(), image: R.image.passDelete()!), style: .default, handler: { action in self.deleteTokenAlert()})
        actionController.addAction(editCardAction)
        actionController.addAction(deleteCardAction)
        actionController.addAction(deleteTokenAction)
    }
    
    func actionButtonClicked() {
        present(actionController, animated: true, completion: nil)
    }
    
    func deleteTokenAlert() {
        let attributedString = NSAttributedString(string: R.string.localizable.alert_choose_token(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobileBold(size: 16)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!
            ])
        let deleteTokenAlert = UIAlertController(title: "", message:"" , preferredStyle: .alert)
        
        deleteTokenAlert.setValue(attributedString, forKey: "attributedMessage")
        
        let deleteSecondTokenAction = UIAlertAction(title: R.string.localizable.alert_delete_second_token() , style: .default , handler: { alert -> Void in
            
        })
        
        let deleteFirstTokenAction = UIAlertAction(title: R.string.localizable.alert_delete_first_token() , style: .default , handler: { alert -> Void in
            
        })
        
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel() , style: .destructive, handler: {
            (action : UIAlertAction!) -> Void in })
        
    
        deleteTokenAlert.addAction(deleteFirstTokenAction)
        deleteTokenAlert.addAction(deleteSecondTokenAction)
        deleteTokenAlert.addAction(cancelAction)
        
        self.present(deleteTokenAlert, animated: true, completion: nil)
        
        let subview = (deleteTokenAlert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 10
        subview.backgroundColor = R.color.primaryLight()
    }
    
    func editCardAlert() {
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
            textField.text = self.selectedCard?.cardName
            
        }
        
        let saveAction = UIAlertAction(title: R.string.localizable.save() , style: .default, handler: { alert -> Void in
            if let newCardName = editCardAlert.textFields![0].text {
            let card = self.selectedCard?.copy() as! Card
            card.cardName = newCardName
            self.cardListPresenter?.editCard(card: card)
                
            }
        })
        
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel() , style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        editCardAlert.addAction(cancelAction)
        editCardAlert.addAction(saveAction)
        
        self.present(editCardAlert, animated: true, completion: nil)
        
        let subview = (editCardAlert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 10
        subview.backgroundColor = R.color.primaryLight()
    }
    
    func deleteCardAlert() {
        let attributedString = NSAttributedString(string: R.string.localizable.lb_are_you_sure(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobileBold(size: 16)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!
            ])
        let deleteCardAlert = UIAlertController(title: "", message:"" , preferredStyle: .alert)
        
        deleteCardAlert.setValue(attributedString, forKey: "attributedMessage")
        
        let deleteAction = UIAlertAction(title: R.string.localizable.delete_card() , style: .default , handler: { alert -> Void in
            self.cardListPresenter?.deleteCard(identifier: (self.selectedCard?.id)!)
        })
        
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel() , style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        deleteCardAlert.addAction(cancelAction)
        deleteCardAlert.addAction(deleteAction)
        
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
        pagerList.removeAll()
        for i in (banks?.indices)! {
            pagerList.append(CardPagerViewAdapter(sender: banks![i]))
        }
        initCardListPagerView()
    }
    
    func noBank() {
        
    }
    
    func initCardListPagerView() {
        var y = 0
        if pagerList.count > 0 {
            
            vScroll.subviews.forEach({ $0.removeFromSuperview() })
            
            for i in pagerList.indices {
                let screenBounds =  UIScreen.main.bounds
                
                let frame = CGRect(x: 0, y: y, width: Int(screenBounds.width), height: 300)
                let cardListPagerView = FSPagerView(frame: frame)
                y += 330
                
                let addCardNib = UINib(resource: R.nib.addCardPagerViewCell)
                cardListPagerView.register(addCardNib, forCellWithReuseIdentifier: R.nib.addCardPagerViewCell.identifier)
                
                let bankCardNib = UINib(resource: R.nib.bankCardPagerViewCell)
                cardListPagerView.register(bankCardNib, forCellWithReuseIdentifier: R.nib.bankCardPagerViewCell.identifier)
                
                pagerList[i] = CardPagerViewAdapter(sender: banks![i])
                pagerList[i].setDelegate(cardPagerViewDelegate: self)
                cardListPagerView.delegate = pagerList[i]
                cardListPagerView.dataSource = pagerList[i]
                cardListPagerView.itemSize = CGSize(width: 300, height: 300)
                cardListPagerView.interitemSpacing = 10
                vScroll.isScrollEnabled = true
                vScroll.contentSize = CGSize(width: screenBounds.width, height: CGFloat(y + 40))
                vScroll.addSubview(cardListPagerView)
                if updatedCard != nil {
                    pagerList[i].setCardDataSource(updatedCard: updatedCard!)
                }
                cardListPagerView.reloadData()
            }
        }
    }
    
    func navigateToImportToken() {
//        performSegue(withIdentifier: R.segue., sender: <#T##Any?#>)
    }
}

