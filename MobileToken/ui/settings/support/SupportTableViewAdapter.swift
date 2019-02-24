import Foundation
import UIKit

protocol SupportTableViewAdapterProtocol {
    func selectedRow()
}

class SupportTableViewAdapter :  NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var supportTableViewAdapterProtocol : SupportTableViewAdapterProtocol?
    var sender:SupportViewController?
    
    func setDelegate(supportTableViewAdapterProtocol:SupportTableViewAdapterProtocol) {
        self.supportTableViewAdapterProtocol = supportTableViewAdapterProtocol
    }
    
    init(sender:SupportViewController) {
        self.sender = sender
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseSupportTableViewCell" , for: indexPath) as! SupportTableViewCell
        cell.imageLogo.backgroundColor = R.color.primaryDark()
        if indexPath.row == 0 {
            cell.imageLogo.image = UIImage(named: R.image.bankAyandehLogo.name)
            cell.labelBankName.text = R.string.localizable.ayande()
            cell.labelPhoneNumber.text = R.string.localizable.ayande_phone()
        }
        else {
            cell.imageLogo.image = UIImage(named: R.image.bankSaderatLogo.name)
            cell.labelBankName.text = R.string.localizable.saderat()
            cell.labelPhoneNumber.text = R.string.localizable.saderat_phone()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}
