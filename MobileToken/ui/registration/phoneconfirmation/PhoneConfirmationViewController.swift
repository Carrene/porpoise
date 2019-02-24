import UIKit

class PhoneConfirmationViewController: BaseViewController,PhoneConfirmationViewProtocol,UITextFieldDelegate {
   
    @IBOutlet var viewChangeNumber: UIView!
    @IBOutlet var textFieldCode: UITextField!
    @IBOutlet var viewCode: UIView!
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var labelChangeNumber: UILabel!
    @IBOutlet var labelCounter: UILabel!
    @IBOutlet var NavigationItemTitle: UINavigationItem!
    @IBOutlet var viewTextfield: UIView!
    @IBOutlet var labelEnterCode: UILabel!
    
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
        viewTextfield.layer.cornerRadius = 5
        viewTextfield.layer.borderColor = R.color.secondary()!.cgColor
        viewTextfield.layer.borderWidth = 1
        viewChangeNumber.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.5).cgColor
        viewChangeNumber.layer.borderWidth = 1
        viewCode.layer.borderWidth = 1
        viewCode.layer.borderColor = R.color.buttonColor()?.withAlphaComponent(0.15).cgColor
        labelChangeNumber.layer.backgroundColor = R.color.buttonColor()?.withAlphaComponent(0.15).cgColor
        labelChangeNumber.layer.cornerRadius = 10
        labelCounter.layer.backgroundColor = R.color.primary()?.cgColor
        //labelCounter.layer.cornerRadius = 10
        viewCode.layer.cornerRadius = 10
        viewChangeNumber.layer.cornerRadius = 10
        labelChangeNumber.font = UIHelper.iranSansBold(size: 16)
        textFieldCode.delegate = self
        labelPhone.text = phoneNumber
        labelChangeNumber.isUserInteractionEnabled = true
        labelEnterCode.font = R.font.iranSansMobile(size: 12)
        textFieldCode.attributedPlaceholder = NSAttributedString(string: "کد فعال سازی",
                                                             attributes: [NSAttributedString.Key.foregroundColor: R.color.buttonColor()!.withAlphaComponent(0.5)])
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
        
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_activation_code_is_not_valid(), color: R.color.errorDark()!, duration: .middle)
    }
    
    func showSSMNotAvailable() {
        
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_SSM_is_not_available(), color: R.color.errorDark()!, duration: .middle)
    }
    
    func showServerError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_server_error(), color: R.color.errorDark()!, duration: .middle)
    }
    
    func showNetworkError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_network_error(), color: R.color.errorDark()!)
    }
    

    
    func segue() {
        performSegue(withIdentifier: R.segue.phoneConfirmationViewController.phoneConfirmationToCardList, sender: self)
    }
    @IBAction func onConfirmButton(_ sender: UIBarButtonItem) {
        let user = User(phone: self.phoneNumber, activationCode: textFieldCode.text!, bank: selectedBank!)
        if textFieldCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(user:user)
        }
    }
    
    @IBAction func onDoneKeyboard(_ sender: UITextField) {
//        let user = User(phone: self.phoneNumber, activationCode: textFieldCode.text!, bank: selectedBank!)
//        if textFieldCode.text != "" && self.phoneNumber != "" {
//            presenter?.bind(user:user)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! TabBarViewController).selectedIndex = 1
    }
}
