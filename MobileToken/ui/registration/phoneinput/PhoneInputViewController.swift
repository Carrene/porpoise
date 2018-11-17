//
//  PhoneInputViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/23/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import FSPagerView
import CountryPickerView
class PhoneInputViewController: UIViewController, BankPagerViewDelegate,CountryPickerViewDelegate,CountryPickerViewDataSource {
    
    
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var lbPhoneCode: UILabel!
    @IBOutlet weak var fpvBank: FSPagerView!
    @IBOutlet var vCountryPicker: CountryPickerView!
    
    var bankPagerViewAdapter: BankPagerViewAdapter?
    override func viewDidLoad() {
        super.viewDidLoad()
        initBankPagerView()
        initCountryPicker()
        lbPhoneCode.font = UIHelper.iranSanseBold(size: 16)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
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
    
    func initCountryPicker() {
        self.vCountryPicker.textColor = .white
        vCountryPicker.delegate = self
        vCountryPicker.dataSource = self
        vCountryPicker.showPhoneCodeInView = false
        vCountryPicker.showCountryCodeInView = true
        vCountryPicker.setCountryByPhoneCode("+98")
        let index = vCountryPicker.countries.index(where: { (item) -> Bool in
            item.phoneCode == "+98" })!
        vCountryPicker.countries[index].name = "Iran"
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.lbPhoneCode.text = country.phoneCode
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "country".localized().lowercased()
    }
    
    @IBAction func onBtReceiveActivationCode(_ sender: Any) {
    }
    
    func selectedCard(bankIndex: Int) {
        
    }
}
