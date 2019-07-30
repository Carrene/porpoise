
import UIKit
import PopupDialog


protocol OTPEyeProtocol {
    func eyeSwitchChanged(isEyeON: Bool)
}
class OTPEyeSettingTableViewCell: UITableViewCell {
    var otpEyeProtocol: OTPEyeProtocol?
    @IBOutlet weak var switchEye: UISwitch! 
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            showDialog()
        } else {
            otpEyeProtocol?.eyeSwitchChanged(isEyeON: sender.isOn)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func showDialog() {
        
        let alert = PopupDialog(title:R.string.localizable.alert_show_otp_risk() , message: "")
        alert.transitionStyle = .zoomIn
        alert.buttonAlignment = .horizontal
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor = R.color.primary()
        dialogAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        dialogAppearance.titleColor = R.color.buttonColor()
        dialogAppearance.messageColor = R.color.buttonColor()
        dialogAppearance.messageFont = R.font.iranSansMobile(size: 14)!
        
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.backgroundColor = R.color.primaryLight()
        containerAppearance.cornerRadius = 10
        
        let cancelButton = DefaultButton(title: R.string.localizable.bt_cancel_otp_alert()) {
            self.switchEye.isOn = false
        }
        
        let okAction = CancelButton(title: R.string.localizable.understand(), dismissOnTap: true) {
            self.otpEyeProtocol?.eyeSwitchChanged(isEyeON: self.switchEye.isOn)
        }
        
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        cancelButtonAppearance.titleColor = R.color.primary()
        cancelButtonAppearance.separatorColor = R.color.secondary()?.withAlphaComponent(0.25)
        cancelButtonAppearance.buttonColor = R.color.secondary()
        
        let okActionAppearance = DefaultButton.appearance()
        okActionAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        okActionAppearance.titleColor = R.color.secondary()
        okActionAppearance.separatorColor = R.color.secondary()?.withAlphaComponent(0.25)
        okActionAppearance.buttonColor = R.color.primary()
        alert.addButtons([okAction, cancelButton])
        topMostController?.present(alert, animated: true, completion: nil)
        
    }
    
}
