//
//  SampleViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/15/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import FSPagerView

class SampleViewController: UIViewController {

    @IBOutlet weak var sv: UIView!
    //    @IBOutlet weak var pagerView: FSPagerView!
    var cardListPagerViewAdapter:CardPagerViewAdapter?
    
    let pagerView = FSPagerView(frame: CGRect(x: 100, y: 0, width: 500, height: 300))
    override func viewDidLoad() {
        super.viewDidLoad()
        initCardListPagerView()
        // Do any additional setup after loading the view.
    }
    
    func initCardListPagerView() {
        

        let addCardNib = UINib(resource: R.nib.addCardPagerViewCell)
        pagerView.register(addCardNib, forCellWithReuseIdentifier: R.nib.addCardPagerViewCell.identifier)
        
        let bankCardNib = UINib(resource: R.nib.bankCardPagerViewCell)
        pagerView.register(bankCardNib, forCellWithReuseIdentifier: R.nib.bankCardPagerViewCell.identifier)
        
        cardListPagerViewAdapter = CardPagerViewAdapter()
        pagerView.delegate = cardListPagerViewAdapter
        pagerView.dataSource = cardListPagerViewAdapter
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.itemSize = CGSize(width: 300, height: 300)
        pagerView.interitemSpacing = 10
        //        vStack.addArrangedSubview(cardListPagerView)
        self.view.addSubview(pagerView)
        pagerView.reloadData()
        self.view.addSubview(pagerView)
//        sv.addSubview(pagerView)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
