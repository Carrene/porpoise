

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
    }
    
    func initUIComponent() {
        labelChooseYourBank.font = R.font.iranSansMobileBold(size: 16)
        labelEnterYourPhone.font = R.font.iranSansMobileMedium(size: 16)
        viewPhone.layer.cornerRadius = 10
        textFieldPhoneNumber.delegate = self
        buttonRegister.layer.cornerRadius = 10
        
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
    
   
    @IBAction func onDoneKeyboard(_ sender: UITextField) {
        if textFieldPhoneNumber.text != "" {
            self.presenter.claim(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!)
        }
    }
    @IBAction func onButtonRegister(_ sender: UIButton) {
        if textFieldPhoneNumber.text != "" {
            buttonRegister.isEnabled = true
            self.presenter.claim(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!)
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
    
}

