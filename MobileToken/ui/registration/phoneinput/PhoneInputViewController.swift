//
//  PhoneInputViewController.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/23/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import CountryPickerView
import IQKeyboardManager

class PhoneInputViewController: UIViewController, BankCollectionViewDelegate,CountryPickerViewDelegate,CountryPickerViewDataSource, PhoneInputViewProtocol,UITextFieldDelegate {
    
    @IBOutlet var labelEnterYourPhone: UILabel!
    @IBOutlet var labelChooseYourBank: UILabel!
    @IBOutlet var textFieldPhoneNumber: UITextField!
    @IBOutlet var labelPhoneCode: UILabel!
    @IBOutlet var collectionViewbank: UICollectionView!
    @IBOutlet var countryPickerView: CountryPickerView!
    @IBOutlet var viewPhone: UIView!
    @IBOutlet var buttonRegister: UIButton!
    
    
    var bankCollectionViewAdapter: BankCollectionViewAdapter?
    var presenter: PhoneInputPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneInputPresenter(view: self)
        initBankCollectionView()
        initCountryPicker()
        

    }
    //TODDO(FATEME) set button background disable state
    override func viewDidAppear(_ animated: Bool) {
        initUIComponent()
        self.hideKeyboardWhenTappedAround()
        buttonRegister.isEnabled = false
        //buttonRegister.setBackgroundColor((R.color.secondary()?.withAlphaComponent(0.2))!, for: UIControl.State.disabled)
    }
    
    func initUIComponent() {
        labelPhoneCode.font = R.font.iranSansMobileBold(size: 16)
        labelChooseYourBank.font = R.font.iranSansMobileBold(size: 16)
        labelEnterYourPhone.font = R.font.iranSansMobileMedium(size: 16)
        textFieldPhoneNumber.font = R.font.iranSansMobileMedium(size: 16)
        viewPhone.layer.cornerRadius = 10
        textFieldPhoneNumber.delegate = self
        buttonRegister.layer.cornerRadius = 10
        //buttonRegister.setBackgroundColor(R.color.secondary()!, for: UIControl.State.normal)
        
    }
    
    func initBankCollectionView() {
        let bankNib = UINib(resource: R.nib.bankCollectionViewCell)
        collectionViewbank.register(bankNib, forCellWithReuseIdentifier: R.nib.bankCollectionViewCell.identifier)
        bankCollectionViewAdapter = BankCollectionViewAdapter()
        bankCollectionViewAdapter?.setDelegate(bankPagerViewDelegate: self)
        collectionViewbank.delegate = bankCollectionViewAdapter
        collectionViewbank.dataSource = bankCollectionViewAdapter
        collectionViewbank.allowsMultipleSelection = false
        setBankList()
        collectionViewbank.reloadData()
    }
    
    func initCountryPicker() {
        self.countryPickerView.textColor = .white
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.showPhoneCodeInView = false
        countryPickerView.showCountryCodeInView = true
        countryPickerView.setCountryByPhoneCode("+98")
        let index = countryPickerView.countries.index(where: { (item) -> Bool in
            item.phoneCode == "+98" })!
        countryPickerView.countries[index].name = "Iran"
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.labelPhoneCode.text = country.phoneCode
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"۰۱۲۳۴۵۶۷۸۹").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
   
    @IBAction func onDoneKeyboard(_ sender: UITextField) {
        if textFieldPhoneNumber.text != "" {
            self.presenter.claim(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!)
        }
    }
    
    @IBAction func onTfPhoneEditDidChanged(_ sender: UITextField) {
        if textFieldPhoneNumber.text != "" {
            buttonRegister.isEnabled = true
        }
        else {
            buttonRegister.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return R.string.localizable.country()
    }
    //TODO(Fateme): CORRECT 400 AND STRINGS
    func showBadRequestError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_wrong_phone(), color: R.color.errorColor()!, duration: .middle)
    }
    
     func setBankList() {
        bankCollectionViewAdapter?.setDataSource(banks: presenter.getBankList())
    }
    
    func navigateToPhoneConfirmation(phone:String) {
        performSegue(withIdentifier: R.segue.phoneInputViewController.phoneInputToActivationSegue, sender: self)
    }
    
    func selectedBank(bankIndex: Int) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.phoneInputViewController.phoneInputToActivationSegue.identifier {
        (segue.destination as! PhoneConfirmationViewController).setPhoneNumber(phone:labelPhoneCode.text!+textFieldPhoneNumber.text! )
        }
    }
    
    @IBAction func onRegister(_ sender: UIBarButtonItem) {
        if textFieldPhoneNumber.text != "" {
            self.presenter.claim(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!)
        }
    }
}

