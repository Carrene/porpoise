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
    
        labelTitle.font = UIHelper.iranSansBold(size: 16)
        viewCode.layer.cornerRadius = 10
        viewChangeNumber.layer.cornerRadius = 10
        labelPhone.font = UIHelper.iranSansMedium(size: 16)
        labelCounter.font = UIHelper.iranSansBold(size: 16)
        labelChangeNumber.font = UIHelper.iranSansBold(size: 16)
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 10, width: 20, height: 11))
        iconView.image = R.image.key()
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        textFieldCode.leftView = iconContainerView
        textFieldCode.leftViewMode = .always
        textFieldCode.font = UIHelper.iranSansBold(size: 20)
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
    
    func setPhoneNumber(phone:String) {
        
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
        
        if textFieldCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(phone: self.phoneNumber, activationCode: textFieldCode.text!)
        }
    }
    
    func showBadRequestError() {
        
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_activation_code_is_not_valid(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func showSSMNotAvailable() {
        
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_SSM_is_not_available(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func segue() {
        //performSegue
    }
    
    @IBAction func onDoneKeyboard(_ sender: UITextField) {
        
        if textFieldCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(phone: self.phoneNumber, activationCode: textFieldCode.text!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
