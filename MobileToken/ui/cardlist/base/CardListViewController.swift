import XLActionController
import UIKit
import FSPagerView

class CardListViewController: BaseViewController,CardListViewProtocol,CardPagerViewDelegate {
    
    @IBOutlet weak var vScroll: UIScrollView!
    
    private var cardListPagerViewAdapter:CardPagerViewAdapter?
    private var pagerList = [CardPagerViewAdapter]()
    private var cardListPresenter : CardListPresenterProtocol?
    let actionController = MobileTokenActionSheetController()
    private var banks : [Bank]?
    private var selectedCard:Card?
    
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
    
    func initActionSheet() {
        let editCardAction = Action(ActionData(title: R.string.localizable.ash_edit_card_name(), image: R.image.cardEdit()!), style: .default, handler: { action in self.editCardAlert()})
        let deleteCardAction = Action(ActionData(title: R.string.localizable.ash_delete_card(), image: R.image.cardDelete()!), style: .default, handler: { action in })
        actionController.addAction(editCardAction)
        actionController.addAction(deleteCardAction)
    }
    
    func actionButtonClicked() {
        present(actionController, animated: true, completion: nil)
    }
    
    func editCardAlert() {
        let attributedString = NSAttributedString(string: R.string.localizable.lb_add_card_name(), attributes: [
            NSAttributedString.Key.font : R.font.iranSansMobile(size: 12)!,
            NSAttributedString.Key.foregroundColor : R.color.buttonColor()!
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
    
    func addCard(cardName:String ,selectedBank:Bank) {
        let card = Card(number: "", bank: selectedBank, cardName: cardName, cardType: Card.CardTypeEnum.BANK )
        cardListPresenter?.addCard(card: card, bank: selectedBank)
    }
    
    func reloadCardPager() {
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
                cardListPagerViewAdapter = CardPagerViewAdapter(sender: banks![i])
                cardListPagerViewAdapter = pagerList[i]
                cardListPagerViewAdapter?.setDelegate(cardPagerViewDelegate: self)
                cardListPagerView.delegate = cardListPagerViewAdapter
                cardListPagerView.dataSource = cardListPagerViewAdapter
                cardListPagerView.itemSize = CGSize(width: 300, height: 300)
                cardListPagerView.interitemSpacing = 10
                
                vScroll.isScrollEnabled = true
                vScroll.contentSize = CGSize(width: screenBounds.width, height: CGFloat(y + 40))
                vScroll.addSubview(cardListPagerView)
                cardListPagerView.reloadData()
            }
        }
    }
}

