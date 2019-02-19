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
        buttonFirstToken.layer.borderWidth = 1
        buttonFirstToken.layer.borderColor = R.color.secondary()?.cgColor
        buttonFirstToken.layer.cornerRadius = 10
        buttonSecondToken.layer.borderWidth = 1
        buttonSecondToken.layer.borderColor = R.color.secondary()?.cgColor
        buttonSecondToken.layer.cornerRadius = 10
        buttonSecondToken.setTitleColor(R.color.buttonColor()?.withAlphaComponent(0.5), for: .disabled)
        buttonFirstToken.setTitleColor(R.color.buttonColor()?.withAlphaComponent(0.5), for: .disabled)
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
            buttonFirstToken.backgroundColor = R.color.secondary()
            buttonFirstToken.setTitleColor(R.color.primaryDark(), for: .normal)
        }
        else {
            buttonFirstToken?.isSelected = false
            buttonFirstToken.backgroundColor = R.color.primaryDark()
            buttonFirstToken.setTitleColor(R.color.secondary(), for: .normal)
            
        }
        
    }
    
    @IBAction func onDeleteSecondToken(_ sender: UIButton) {
        if !(buttonSecondToken?.isSelected)! {
            buttonSecondToken?.isSelected = true
            buttonSecondToken.backgroundColor = R.color.secondary()
            buttonSecondToken.setTitleColor(R.color.primaryDark(), for: .normal)
        }
        else {
            buttonSecondToken?.isSelected = false
            buttonSecondToken.backgroundColor = R.color.primaryDark()
            buttonSecondToken.setTitleColor(R.color.secondary(), for: .normal)
            
        }
    }
    
}
