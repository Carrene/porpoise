import Foundation
import UIKit

class HelpTableViewAdapter : NSObject,UITableViewDelegate,UITableViewDataSource {
    
    private var dataSource = [R.string.localizable.help_add_bank(),R.string.localizable.help_add_card(),R.string.localizable.help_edit_cardName(),R.string.localizable.help_delete_card(),R.string.localizable.help_get_token(),R.string.localizable.help_add_token(),R.string.localizable.help_change_token(),R.string.localizable.help_custom_token(),R.string.localizable.help_copy_token(),R.string.localizable.help_delete_token(),R.string.localizable.help_edit_phone()]
    
    private var sender:HelpViewController?
    
    func setDataSource(dataSource:[String]) {
        self.dataSource = dataSource
    }
    
    init(sender:HelpViewController) {
        self.sender = sender
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseHelpCell.identifier, for: indexPath) as! HelpTableViewCell
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
