import XLActionController
import UIKit
import FSPagerView

class CardListViewController: BaseViewController,CardListViewProtocol {
   
    @IBOutlet weak var vScroll: UIScrollView!
    
    private var cardListPagerViewAdapter:CardPagerViewAdapter?
    private var pagerList = [CardPagerViewAdapter]()
    private var cardListPresenter : CardListPresenterProtocol?
    let actionController = MobileTokenActionSheetController()
    private var selectedWalletIndex: Int?
    private var banks : [Bank]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActionSheet()
        self.cardListPresenter = CardListPresenter(view: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardListPresenter?.getBankList()
        initCardListPagerView()
    }
    
    func initActionSheet() {
        let editCardAction = Action(ActionData(title: R.string.localizable.ash_edit_card_name(), image: R.image.cardEdit()!), style: .default, handler: { action in })
        let deleteCardAction = Action(ActionData(title: R.string.localizable.ash_delete_card(), image: R.image.cardDelete()!), style: .default, handler: { action in })
        actionController.addAction(editCardAction)
        actionController.addAction(deleteCardAction)
    }
    
    func actionSheetButtonClicked() {
        present(actionController, animated: true, completion: nil)
    }
    
    func initUIComponents() {
        
    }
    
    func initListeners() {
        
    }
    
    func setBankList(banks: [Bank]) {
        self.banks = banks
        initPagerList()
    }
    
    func initPagerList() {
        pagerList.removeAll()
        for _ in banks! {
            pagerList.append(CardPagerViewAdapter())
        }
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

                cardListPagerViewAdapter = pagerList[i]
                
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
