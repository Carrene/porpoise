//
//  BankPagerViewAdapter.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/23/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import Foundation
import FSPagerView

protocol BankPagerViewDelegate {
    func selectedCard(cardIndex: Int)
}
class BankPagerViewAdapter:NSObject, FSPagerViewDelegate, FSPagerViewDataSource {
    
    var bankPagerViewDelegate: BankPagerViewDelegate?
    var selectedIndex = 0
    
    func setDelegate(cardPagerViewDelegate: BankPagerViewDelegate) {
        self.bankPagerViewDelegate = cardPagerViewDelegate
    }
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 2
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.nib.bankPagerViewCell.identifier, at: index) as! BankPagerViewCell
        return cell
    }
    
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
}
