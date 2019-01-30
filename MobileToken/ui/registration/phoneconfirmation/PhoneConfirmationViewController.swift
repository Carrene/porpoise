import UIKit

class PhoneConfirmationViewController: BaseViewController,PhoneConfirmationViewProtocol,UITextFieldDelegate {

    @IBOutlet var viewChangeNumber: UIView!
    @IBOutlet var textFieldCode: UITextField!
    @IBOutlet var viewCode: UIView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var labelChangeNumber: UILabel!
    @IBOutlet var labelCounter: UILabel!
    @IBOutlet var NavigationItemTitle: UINavigationItem!
    @IBOutlet var viewTextfield: UIView!
    
    private var selectedBank : Bank?
    private var presenter:PhoneConfirmationPresenterProtocol?
    private var phoneNumber = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.presenter = PhoneConfirmationPresenter(view: self)
        showTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func initUIComponents() {
        viewTextfield.layer.cornerRadius = 10
        labelTitle.font = UIHelper.iranSansBold(size: 16)
        viewCode.layer.cornerRadius = 10
        viewChangeNumber.layer.cornerRadius = 10
        labelChangeNumber.font = UIHelper.iranSansBold(size: 16)
        textFieldCode.delegate = self
        labelPhone.text = phoneNumber
        labelChangeNumber.isUserInteractionEnabled = true
    }
    
    func initListeners() {
        
        let tapChangeNumber = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        labelChangeNumber.addGestureRecognizer(tapChangeNumber)
        let tapResendCode = UITapGestureRecognizer(target: self, action: #selector(resetTimer(_:)))
        labelCounter.addGestureRecognizer(tapResendCode)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        presenter?.invalidateTimer()
    }
    
    func setData(phone:String,bank:Bank) {
        self.selectedBank = bank
        self.phoneNumber = phone
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
        presenter?.invalidateTimer()
        presenter?.initCodeTimer()
    }
    
    @objc func dismiss(_ sender: UITapGestureRecognizer) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    @IBAction func onTfPhoneEditDidChanged(_ sender: UITextField) {
        
        if textFieldCode.text != "" {
            //self.barButtonItemConfirm.isEnabled = true
        }
        else {
            //self.barButtonItemConfirm.isEnabled = false
        }
    }
    
    @IBAction func onConfirm(_ sender: UIBarButtonItem) {
        let user = User(phone: self.phoneNumber, activationCode: textFieldCode.text!, bank: selectedBank)
        if textFieldCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(user:user)
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        return count <= 6
    }
    
    func showBadRequestError() {
        
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_activation_code_is_not_valid(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func showSSMNotAvailable() {
        
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_SSM_is_not_available(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func showServerError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_server_error(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func segue() {
        performSegue(withIdentifier: R.segue.phoneConfirmationViewController.phoneConfirmationToCardList, sender: self)
    }
    
    @IBAction func onDoneKeyboard(_ sender: UITextField) {
        let user = User(phone: self.phoneNumber, activationCode: textFieldCode.text!, bank: selectedBank!)
        if textFieldCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(user:user)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! TabBarViewController).selectedIndex = 0
    }
}
