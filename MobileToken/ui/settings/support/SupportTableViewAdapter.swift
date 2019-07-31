import Foundation
import UIKit
import ObjectMapper

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
        let banks = Mapper<Bank>().mapArray(JSONfile:  "banks.json")
        return banks?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let banks = Mapper<Bank>().mapArray(JSONfile:  "banks.json")
        let bank = banks![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseSupportTableViewCell" , for: indexPath) as! SupportTableViewCell
        cell.imageLogo.image = BankUtil.getLightLogo(bank: bank)
        cell.labelBankName.text = BankUtil.getName(bank: bank)
        cell.labelPhoneNumber.text = bank.phone
        cell.selectionStyle = .none
        return cell
    }
    
    
}
