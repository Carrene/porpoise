//
//  TokenViewController.swift
//  
//
//  Created by hamed akhlaghi on 8/15/1397 AP.
//

import UIKit
import FSPagerView
class TokenListViewController: UIViewController {
    @IBOutlet weak var vStack: UIStackView!
    
    @IBOutlet weak var vScroll: UIScrollView!
    
    
    var selectedWalletIndex: Int?
    var cardListPagerViewAdapter:CardPagerViewAdapter?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        initCardListPagerView()
        
    }
    
    func initCardListPagerView() {
        for i in 0...1000 {

//            vStack.addArrangedSubview(view)
            let cardListPagerView = FSPagerView()
            let addCardNib = UINib(resource: R.nib.addCardPagerViewCell)
            cardListPagerView.register(addCardNib, forCellWithReuseIdentifier: R.nib.addCardPagerViewCell.identifier)
            
            let bankCardNib = UINib(resource: R.nib.bankCardPagerViewCell)
            cardListPagerView.register(bankCardNib, forCellWithReuseIdentifier: R.nib.bankCardPagerViewCell.identifier)
            
            cardListPagerViewAdapter = CardPagerViewAdapter()
            cardListPagerView.delegate = cardListPagerViewAdapter
            cardListPagerView.dataSource = cardListPagerViewAdapter
            cardListPagerView.transformer = FSPagerViewTransformer(type: .linear)
            cardListPagerView.itemSize = CGSize(width: 300, height: 300)
            cardListPagerView.interitemSpacing = 10
            cardListPagerView.reloadData()
            let bt = UIButton()
            bt.setTitle("GTTTT", for: .normal)
            vStack.addArrangedSubview(bt)
            
        }
    }

    
}
