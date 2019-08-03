import PopupDialog
import Foundation

extension UIViewController {
    
    func showForceCloseDialog(title: String, message: String, doneTitle: String, doneAction: @escaping () -> ()) {
        let alert = PopupDialog(title: title , message: message)
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
        
        let doneAction = CancelButton(title: doneTitle , action: doneAction)
        
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont = R.font.iranSansMobileBold(size: 16)!
        cancelButtonAppearance.titleColor = R.color.primary()
        cancelButtonAppearance.separatorColor = R.color.secondary()?.withAlphaComponent(0.25)
        cancelButtonAppearance.buttonColor = R.color.secondary()
        
        
        alert.addButtons([doneAction])
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
