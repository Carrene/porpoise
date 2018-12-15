import XLActionController
import UIKit
import FSPagerView

class TokenListViewController: BaseViewController {
    
    @IBOutlet weak var vScroll: UIScrollView!
    
    var cardListPagerViewAdapter:CardPagerViewAdapter?
    var pagerList = [CardPagerViewAdapter(), CardPagerViewAdapter(), CardPagerViewAdapter()]
    let actionController = MobileTokenActionSheetController()
    var selectedWalletIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActionSheet()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    
    func initCardListPagerView() {
        var y = 0
        for i in 0...2 {
            
            let screenBounds =  UIScreen.main.bounds
            
            let frame = CGRect(x: 0, y: y, width: Int(screenBounds.width), height: 300)
            let cardListPagerView = FSPagerView(frame: frame)
            y += 340
            
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
