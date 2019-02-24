import UIKit

class DeleteTokenAlertViewController: BaseViewController {
    
    @IBOutlet var buttonFirstToken: UIButton!
    @IBOutlet var buttonSecondToken: UIButton!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initUIComponents() {
        buttonFirstToken.isEnabled = false
        buttonSecondToken.isEnabled = false
        
        buttonFirstToken.layer.cornerRadius = 10
        buttonFirstToken.layer.shadowPath = UIBezierPath(roundedRect: buttonFirstToken.bounds, cornerRadius: 10).cgPath
        buttonFirstToken.layer.shadowRadius = 3
        buttonFirstToken.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        buttonFirstToken.layer.shadowOpacity = 0.2
        //buttonFirstToken.layer.backgroundColor = R.color.primaryLight()?.cgColor
        buttonFirstToken.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        buttonFirstToken.layer.borderWidth = 2
        buttonFirstToken.layer.borderColor = R.color.primary()?.cgColor
        
        
        buttonSecondToken.layer.cornerRadius = 10
        buttonSecondToken.layer.shadowPath = UIBezierPath(roundedRect: buttonSecondToken.bounds, cornerRadius: 10).cgPath
        buttonSecondToken.layer.shadowRadius = 3
        buttonSecondToken.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        buttonSecondToken.layer.shadowOpacity = 0.2
        //buttonSecondToken.layer.backgroundColor = R.color.primaryLight()?.cgColor
        buttonSecondToken.layer.shadowColor = R.color.buttonColor()?.withAlphaComponent(0.25).cgColor
        buttonSecondToken.layer.borderWidth = 1
        buttonSecondToken.layer.borderColor = R.color.primary()?.cgColor
        
        
        buttonSecondToken.setTitleColor(R.color.buttonColor(), for: .disabled)
        buttonFirstToken.setTitleColor(R.color.buttonColor(), for: .disabled)
        label.font = R.font.iranSansMobileBold(size: 16)
    }
    
    func initListeners() {
        
    }
    
    func setTokenList(card:Card) {
        card.TokenList.forEach{token in
            if token.cryptoModuleId == Token.CryptoModuleId.one {
                self.buttonFirstToken.isEnabled = true
            } else if token.cryptoModuleId == Token.CryptoModuleId.two {
                self.buttonSecondToken.isEnabled = true
            }
        }
        
    }
    
    @IBAction func onDeleteFirstToken(_ sender: UIButton) {
        if !(buttonFirstToken?.isSelected)! {
            buttonFirstToken?.isSelected = true
            buttonFirstToken.layer.borderColor = R.color.secondary()?.cgColor
            buttonFirstToken.setTitleColor(R.color.primary(), for: .normal)
        }
        else {
            buttonFirstToken?.isSelected = false
            buttonFirstToken.layer.borderColor = R.color.primaryLight()?.cgColor
            buttonFirstToken.setTitleColor(R.color.secondary(), for: .normal)
            
        }
        
    }
    
    @IBAction func onDeleteSecondToken(_ sender: UIButton) {
        if !(buttonSecondToken?.isSelected)! {
            buttonSecondToken?.isSelected = true
            buttonSecondToken.layer.borderColor = R.color.secondary()?.cgColor
            buttonSecondToken.setTitleColor(R.color.primary(), for: .normal)
        }
        else {
            buttonSecondToken?.isSelected = false
            buttonSecondToken.layer.borderColor = R.color.primaryLight()?.cgColor
            buttonSecondToken.setTitleColor(R.color.secondary(), for: .normal)
            
        }
    }
    
}
