//
//  PhoneInputViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/23/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import FSPagerView
class PhoneInputViewController: UIViewController, BankPagerViewDelegate {
    
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var lbPhoneCode: UILabel!
    @IBOutlet weak var fpvBank: FSPagerView!
    
    var bankPagerViewAdapter: BankPagerViewAdapter?
    override func viewDidLoad() {
        super.viewDidLoad()
        initBankPagerView()

    }
    
    func initBankPagerView() {
        let bankNib = UINib(resource: R.nib.bankPagerViewCell)
        fpvBank.register(bankNib, forCellWithReuseIdentifier: R.nib.bankPagerViewCell.identifier)
        bankPagerViewAdapter = BankPagerViewAdapter()
        bankPagerViewAdapter?.setDelegate(bankPagerViewDelegate: self)
        fpvBank.delegate = bankPagerViewAdapter
        fpvBank.dataSource = bankPagerViewAdapter
        fpvBank.itemSize = CGSize(width: 140, height: 100)
        fpvBank.interitemSpacing = 10
        fpvBank.reloadData()
    }
    
    @IBAction func onBtReceiveActivationCode(_ sender: Any) {
    }
    
    func selectedCard(bankIndex: Int) {
        
    }
}
