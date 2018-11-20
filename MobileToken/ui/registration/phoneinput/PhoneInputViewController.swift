//
//  PhoneInputViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/23/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import CountryPickerView
class PhoneInputViewController: UIViewController, BankCollectionViewDelegate,CountryPickerViewDelegate,CountryPickerViewDataSource, PhoneInputViewProtocol {
    
    @IBOutlet var lbEnterPhone: UILabel!
    @IBOutlet var lbChooseBank: UILabel!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var lbPhoneCode: UILabel!
    @IBOutlet var bankCollectionView: UICollectionView!
    @IBOutlet var vCountryPicker: CountryPickerView!
    @IBOutlet var vPhone: UIView!
    var bankCollectionViewAdapter: BankCollectionViewAdapter?
    var presenter: PhoneInputPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneInputPresenter(view: self)
        initBankCollectionView()
        initCountryPicker()
        initUIComponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
    }
    
    func initUIComponent() {
        lbPhoneCode.font = R.font.iranSansMobileBold(size: 16)
        lbChooseBank.font = R.font.iranSansMobileBold(size: 16)
        lbEnterPhone.font = R.font.iranSansMobileMedium(size: 16)
        tfPhoneNumber.font = R.font.iranSansMobileMedium(size: 16)
        vPhone.layer.cornerRadius = 10
    }
    
    func initBankCollectionView() {
        let bankNib = UINib(resource: R.nib.bankCollectionViewCell)
        bankCollectionView.register(bankNib, forCellWithReuseIdentifier: R.nib.bankCollectionViewCell.identifier)
        bankCollectionViewAdapter = BankCollectionViewAdapter()
        bankCollectionViewAdapter?.setDelegate(bankPagerViewDelegate: self)
        bankCollectionView.delegate = bankCollectionViewAdapter
        bankCollectionView.dataSource = bankCollectionViewAdapter
        bankCollectionView.reloadData()
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
    //TODO: CORRECT 400 AND STRINGS
    func showBadRequestError() {
        SnackBarHelper.init(message: "wrong phone", color: R.color.errorColor()!, duration: .middle).show()
    }
    
    func setBankList(bankList: [Bank]) {
        
    }
    
    func navigateToPhoneConfirmation() {
        performSegue(withIdentifier: "phoneInputToActivationSegue", sender: self)
    }
   
    
    @IBAction func onRegister(_ sender: UIBarButtonItem) {
        if tfPhoneNumber.text != "" {
            self.presenter.claim(phone: lbPhoneCode.text!+tfPhoneNumber.text!)
        }
    }
    func selectedCard(bankIndex: Int) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        navigationController?.navigationBar.backIndicatorImage = R.image.arrowLeft()
        backItem.title = ""
        backItem.tintColor = R.color.secondary()
        navigationItem.backBarButtonItem = backItem
    }
}

