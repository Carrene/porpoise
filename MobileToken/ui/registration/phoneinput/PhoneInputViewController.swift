import UIKit
import CountryPickerView
import IQKeyboardManager
import InputMask

class PhoneInputViewController: UIViewController, BankCollectionViewDelegate,CountryPickerViewDelegate,CountryPickerViewDataSource, PhoneInputViewProtocol,UITextFieldDelegate,MaskedTextFieldDelegateListener {
    
    
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
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var viewCountry: UIView!
    @IBOutlet var confirmBarButton: UIBarButtonItem!
    @IBOutlet var viewLine: UIView!
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    private var inputPhone : String!
    private var maskedDelegate: MaskedTextFieldDelegate!
    private var banks:[Bank]!
    private var bankCollectionViewAdapter: BankCollectionViewAdapter?
    private var presenter: PhoneInputPresenterProtocol!
    private var selectedBank : Bank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneInputPresenter(view: self)
        initUIComponents()
        initListeners()
        initCountryPicker()
        presenter.getBankList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
        //textFieldPhoneNumber.text = ""
//        collectionViewbank.reloadData()
    }
    
    func initUIComponents() {
        labelChooseYourBank.font = R.font.iranSansMobile(size: 16)
        labelEnterYourPhone.font = R.font.iranSansMobileMedium(size: 12)
        labelChooseCountry.font = R.font.iranSansMobileMedium(size: 12)
        
        activityIndicator.color = R.color.secondary()
        
        viewCountry.layer.cornerRadius = 5
        viewCountry.layer.borderColor = R.color.buttonColor()!.cgColor
        viewCountry.layer.borderWidth = 2
        
        viewPhone.layer.borderWidth = 2
        viewPhone.layer.borderColor = R.color.buttonColor()!.cgColor
        viewPhone.layer.cornerRadius = 5
        
        viewTextfields.layer.cornerRadius = 10
        //viewTextfields.layer.shadowPath = UIBezierPath(roundedRect: viewTextfields.bounds, cornerRadius: 10).cgPath
        viewTextfields.layer.shadowRadius = 5
        //viewTextfields.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        viewTextfields.layer.shadowOpacity = 0.2
        viewTextfields.layer.backgroundColor = R.color.primaryLight()?.cgColor
        viewTextfields.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        labelAlreadyRegistered.isHidden = true
        viewLine.isHidden = true
        textFieldPhoneNumber.delegate = self
        inputMask()
    }
    
    func initListeners() {
        
    }
    
    func initBankCollectionView(banks: [Bank]) {
        let bankNib = UINib(resource: R.nib.bankCollectionViewCell)
        collectionViewbank.register(bankNib, forCellWithReuseIdentifier: R.nib.bankCollectionViewCell.identifier)
        bankCollectionViewAdapter = BankCollectionViewAdapter()
        bankCollectionViewAdapter?.setDelegate(bankPagerViewDelegate: self)
        bankCollectionViewAdapter?.setDataSource(banks: banks)
        collectionViewbank.delegate = bankCollectionViewAdapter
        collectionViewbank.dataSource = bankCollectionViewAdapter
        collectionViewbank.allowsMultipleSelection = false
        collectionViewbank.reloadData()
    }
    
    func initCountryPicker() {
        self.countryPickerView.textColor = R.color.buttonColor()!
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.showPhoneCodeInView = false
        countryPickerView.showCountryCodeInView = true
        
        countryPickerView.setCountryByPhoneCode("+98")
        let index = countryPickerView.countries.index(where: { (item) -> Bool in
            item.phoneCode == "+98" })!
        countryPickerView.countries[index].name = "Iran"
        
    }
    
    func inputMask() {
        maskedDelegate = MaskedTextFieldDelegate(format: "[000] [000] [0000] [-----------------------------------------------------]")
        maskedDelegate.listener = self
        textFieldPhoneNumber.delegate = maskedDelegate
    }
    
    open func textField(_ textField: UITextField,didFillMandatoryCharacters complete: Bool,didExtractValue value: String) {
        self.inputPhone = value.replacedArabicPersianDigitsWithEnglish
        }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.labelPhoneCode.text = country.phoneCode
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = countryPickerView.countries
        let index = countries.firstIndex {$0.code == "IL"}
        countries.remove(at: index!)
        return countries
        
    }
    
    @IBAction func onDoneKeyboard(_ sender: UITextField) {

    }
    
    @IBAction func onButtonRegister(_ sender: UIBarButtonItem) {
        if inputPhone?.first == "0" {
            inputPhone?.remove(at: inputPhone.startIndex)
        }
        if inputPhone != nil && inputPhone.count > 0 {
            if selectedBank != nil {
                self.presenter.claim(phone: labelPhoneCode.text!+inputPhone, bank: self.selectedBank! )
            }
            else {
                UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_select_bank_error(), color: R.color.errorDark()!)
            }
        }
        else {
            UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_check_your_input(), color: R.color.errorDark()!, duration: .middle)
        }
        
    }
    
    func startBarIndicator() {
        self.startBarButtonRightIndicator(activityIndicator: activityIndicator)
    }
    
    func endBarIndicator() {
        self.stopBarButtonRightIndicator(btNavigationRight: (self.confirmBarButton)!, activityIndicator: (self.activityIndicator))
    }
    
    func showEverywhereError401() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_everywhere_401(), color: R.color.errorDark()!, duration: .short)
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        return true
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return R.string.localizable.country()
    }
    
    func showBadRequestError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_wrong_phone(), color: R.color.errorDark()!, duration: .short)
        dismissKeyboard()
    }
    
    func showServerError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_server_error(), color: R.color.errorDark()!, duration: .short)
        dismissKeyboard()
    }
    
    func showEverywhereFail() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_everywhere_fail(), color: R.color.errorDark()!, duration: .short)
        dismissKeyboard()
    }
    
    func showNetworkError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_network_error(), color: R.color.errorDark()!)
        dismissKeyboard()
    }
    
    func setBankList(banks : [Bank]) {
        initBankCollectionView(banks: banks)
        self.banks = banks
    }
    
    func navigateToPhoneConfirmation(phone:String) {
        performSegue(withIdentifier: R.segue.phoneInputViewController.phoneInputToActivationSegue, sender: self)
    }
    
    func selectedBank(bankIndex: Int?) {
        if let index = bankIndex {
            presenter.getUser(bank: self.banks[index])
            self.selectedBank = self.banks[index]
        }
    }
    
    func showAlreadyRegistered(phone:String) {
        labelAlreadyRegistered.isHidden = false
        labelPhone.isHidden = false
        viewPhone.isHidden = true
        countryPickerView.isHidden = true
        labelPhone.text = phone
        labelChooseCountry.isHidden = true
        labelEnterYourPhone.isHidden = true
        viewCountry.isHidden = true
        confirmBarButton.isEnabled = false
        viewLine.isHidden = false
    }
    
    func showPhoneInput() {
        viewLine.isHidden = true
        labelAlreadyRegistered.isHidden = true
        labelPhone.isHidden = true
        viewPhone.isHidden = false
        countryPickerView.isHidden = false
        labelChooseCountry.isHidden = false
        labelEnterYourPhone.isHidden = false
        viewCountry.isHidden = false
        confirmBarButton.isEnabled = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.phoneInputViewController.phoneInputToActivationSegue.identifier {
            (segue.destination as! PhoneConfirmationViewController).setData(phone: labelPhoneCode.text!+inputPhone, bank: selectedBank!)
        }
    }
    
}
