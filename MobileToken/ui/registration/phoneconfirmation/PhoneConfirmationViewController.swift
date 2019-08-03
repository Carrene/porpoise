import UIKit
import  InputMask

class PhoneConfirmationViewController: BaseViewController,PhoneConfirmationViewProtocol,UITextFieldDelegate {
   
    @IBOutlet var btConfirmation: UIBarButtonItem!
    @IBOutlet var viewChangeNumber: UIView!
    @IBOutlet var textFieldCode: UITextField!
    @IBOutlet var viewCode: UIView!
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var labelChangeNumber: UILabel!
    @IBOutlet var labelCounter: UILabel!
    @IBOutlet var NavigationItemTitle: UINavigationItem!
    @IBOutlet var viewTextfield: UIView!
    @IBOutlet var labelEnterCode: UILabel!
    @IBOutlet weak var bankNib: BankViewXib!
    
    
    private var selectedBank : Bank?
    private var presenter:PhoneConfirmationPresenterProtocol?
    private var phoneNumber = ""
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneConfirmationPresenter(view: self)
        
        showTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initBankNib(bank: selectedBank!)
    }
    
    func initUIComponents() {
        if #available(iOS 12.0, *) {
            textFieldCode.textContentType = .oneTimeCode
        }
        self.hideKeyboardWhenTappedAround()
        btConfirmation.isEnabled = false
        viewTextfield.layer.cornerRadius = 5
        viewTextfield.layer.borderColor = R.color.secondary()!.cgColor
        viewTextfield.layer.borderWidth = 2
        activityIndicator.color = R.color.secondary()
        textFieldCode.becomeFirstResponder()
        viewCode.layer.shadowPath = UIBezierPath(roundedRect: viewCode.bounds, cornerRadius: 10).cgPath
        viewCode.layer.shadowRadius = 3
        viewCode.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCode.layer.shadowOpacity = 0.2
        viewCode.layer.backgroundColor = R.color.primaryLight()?.cgColor
        viewCode.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewCode.layer.cornerRadius = 10
        viewChangeNumber.layer.cornerRadius = 10
        viewChangeNumber.layer.shadowPath = UIBezierPath(roundedRect: viewChangeNumber.bounds, cornerRadius: 10).cgPath
        viewChangeNumber.layer.shadowRadius = 3
        viewChangeNumber.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewChangeNumber.layer.shadowOpacity = 0.2
        viewChangeNumber.layer.backgroundColor = R.color.primaryLight()?.cgColor
        viewChangeNumber.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        labelChangeNumber.font = UIHelper.iranSansBold(size: 16)
        textFieldCode.delegate = self
        labelPhone.text = phoneNumber
       labelPhone.font = UIHelper.getFont(size: 17)
        labelChangeNumber.isUserInteractionEnabled = true
        labelEnterCode.font = UIHelper.getFont(size: 12)
        textFieldCode.attributedPlaceholder = NSAttributedString(string: R.string.localizable.ph_activation_code(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
        labelCounter.font = UIHelper.getFont(size: 16)
    }
    
    
    
    override func willMove(toParent parent: UIViewController?)
    {
        super.willMove(toParent: parent)
        if parent == nil
        {
            presenter?.invalidateTimer()
        }
    }
    
    func initListeners() {
        let tapChangeNumber = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        labelChangeNumber.addGestureRecognizer(tapChangeNumber)
        let tapResendCode = UITapGestureRecognizer(target: self, action: #selector(resetTimer(_:)))
        labelCounter.addGestureRecognizer(tapResendCode)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
//        presenter?.invalidateTimer()
    }
    
    func setData(phone:String,bank:Bank) {
        self.selectedBank = bank
        self.phoneNumber = phone
        
    }
    
    func initBankNib(bank:Bank) {
        self.bankNib.labelBank.text = BankUtil.getName(bank: bank)
        self.bankNib.imageLogo.image = BankUtil.getLogo(bank: bank)
    }
    
    func showTimer() {
        
        presenter?.initCodeTimer()
    }
    
    func setCounterTitleToResend() {
        
        self.labelCounter.text = R.string.localizable.lb_resend()
        self.labelCounter.isUserInteractionEnabled = true
    }
    
    func setCounterTitleTime(time:String) {
        
        self.labelCounter.text = time
        self.labelCounter.isUserInteractionEnabled = false
    }
    
    @objc func resetTimer(_ sender: UITapGestureRecognizer) {
        
        presenter?.claim(phone: phoneNumber, bank: selectedBank!)
        presenter?.invalidateTimer()
    }
    
    @objc func dismiss(_ sender: UITapGestureRecognizer) {
        presenter?.invalidateTimer()
        navigationController?.popViewController(animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    
    @IBAction func textFieldDidChanged(_ sender: Any) {
        if textFieldCode.text?.count == 6 {
            btConfirmation.isEnabled = true
            onConfirm(btConfirmation)
        }
        else {
            
        }
    }
    
    @IBAction func onTfPhoneEditDidChanged(_ sender: UITextField) {
        
        
    }
    
    func startBarIndicator() {
        self.startBarButtonRightIndicator(activityIndicator: activityIndicator)
    }
    
    func endBarIndicator() {
        self.stopBarButtonRightIndicator(btNavigationRight: (self.btConfirmation)!, activityIndicator: (self.activityIndicator))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        return count <= 6
    }
    
    func showBadRequestError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_activation_code_is_not_valid(), color: R.color.errorDark()!, duration: .short)
        dismissKeyboard()
    }
    
    func showSSMNotAvailable() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_SSM_is_not_available(), color: R.color.errorDark()!, duration: .short)
        dismissKeyboard()
    }
    
    func showEverywhereError401() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_everywhere_401(), color: R.color.errorDark()!, duration: .short)
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
    
    func segue() {
        performSegue(withIdentifier: R.segue.phoneConfirmationViewController.phoneConfirmationToCardList, sender: self)
    }
    
        @IBAction func onConfirm(_ sender: UIBarButtonItem) {
            let code = textFieldCode.text!.replacedArabicPersianDigitsWithEnglish
            let user = User(phone: self.phoneNumber, activationCode: code, bank: selectedBank)
            if textFieldCode.text?.count == 6 && self.phoneNumber != "" {
                presenter?.bind(user:user)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! TabBarViewController).selectedIndex = 1
    }
}
