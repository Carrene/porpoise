import UIKit
import CountryPickerView
import IQKeyboardManager

class PhoneInputViewController: BaseViewController, BankCollectionViewDelegate,CountryPickerViewDelegate,CountryPickerViewDataSource, PhoneInputViewProtocol,UITextFieldDelegate {
    
    @IBOutlet var labelEnterYourPhone: UILabel!
    @IBOutlet var labelChooseYourBank: UILabel!
    @IBOutlet var textFieldPhoneNumber: UITextField!
    @IBOutlet var labelPhoneCode: UILabel!
    @IBOutlet var collectionViewbank: UICollectionView!
    @IBOutlet var countryPickerView: CountryPickerView!
    @IBOutlet var viewTextfields: UIView!
    @IBOutlet var labelChooseCountry: UILabel!
    @IBOutlet var viewPhone: UIView!
    @IBOutlet var labelAlreadyRegistered: UILabel!
    
    
    private var banks:[Bank]!
    private var bankCollectionViewAdapter: BankCollectionViewAdapter?
    private var presenter: PhoneInputPresenterProtocol!
    private var selectedBank : Bank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneInputPresenter(view: self)
        initBankCollectionView()
        initCountryPicker()
        presenter.getBankList()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
        textFieldPhoneNumber.text = ""
        labelPhoneCode.isHidden = true
        viewPhone.isOpaque = false
    }
    

    func initUIComponents() {
        labelChooseYourBank.font = R.font.iranSansMobileBold(size: 16)
        labelEnterYourPhone.font = R.font.iranSansMobileMedium(size: 16)
        labelChooseCountry.font = R.font.iranSansMobileMedium(size: 16)
        countryPickerView.layer.cornerRadius = 10
        viewTextfields.layer.cornerRadius = 10
        textFieldPhoneNumber.delegate = self
        viewPhone.layer.cornerRadius = 10
    }
    
    func initListeners() {
        
    }
    
    func initBankCollectionView() {
        let bankNib = UINib(resource: R.nib.bankCollectionViewCell)
        collectionViewbank.register(bankNib, forCellWithReuseIdentifier: R.nib.bankCollectionViewCell.identifier)
        bankCollectionViewAdapter = BankCollectionViewAdapter()
        bankCollectionViewAdapter?.setDelegate(bankPagerViewDelegate: self)
        collectionViewbank.delegate = bankCollectionViewAdapter
        collectionViewbank.dataSource = bankCollectionViewAdapter
        collectionViewbank.allowsMultipleSelection = false
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
            if selectedBank != nil {
                self.presenter.claim(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!, bank: self.selectedBank! )
            }
            else {
                selectedBank = banks.first
                self.presenter.claim(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!, bank: self.selectedBank! )
            }
        }
    }
    
    @IBAction func onButtonRegister(_ sender: UIButton) {
//        if textFieldPhoneNumber.text != "" {
//            buttonRegister.isEnabled = true
//            self.presenter.claim(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!)
//        }
//        else {
//            buttonRegister.isEnabled = false
//        }
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
    
    func showServerError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_server_error(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func setBankList(banks : [Bank]) {
        bankCollectionViewAdapter?.setDataSource(banks: banks)
        self.banks = banks
    }
    
    func navigateToPhoneConfirmation(phone:String) {
        performSegue(withIdentifier: R.segue.phoneInputViewController.phoneInputToActivationSegue, sender: self)
    }
    
    func selectedBank(bankIndex: Int) {
        presenter.getUser(bank: self.banks[bankIndex])
        self.selectedBank = self.banks[bankIndex]
    }
    
    func showAlreadyRegistered() {
        labelPhoneCode.isHidden = false
        viewPhone.isOpaque = true
    }
    
    func showPhoneInput() {
        labelPhoneCode.isHidden = true
        viewPhone.isOpaque = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.phoneInputViewController.phoneInputToActivationSegue.identifier {
            (segue.destination as! PhoneConfirmationViewController).setData(phone: labelPhoneCode.text!+textFieldPhoneNumber.text!, bank: selectedBank!)
        }
    }
    
}
