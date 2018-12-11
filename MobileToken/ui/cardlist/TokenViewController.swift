

import UIKit
import FSPagerView

class TokenListViewController: UIViewController {
    
    @IBOutlet weak var vScroll: UIScrollView!
    
    var cardListPagerViewAdapter:CardPagerViewAdapter?
    var pagerList = [CardPagerViewAdapter(), CardPagerViewAdapter(), CardPagerViewAdapter()]
    
    
    var selectedWalletIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initCardListPagerView()
        
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
