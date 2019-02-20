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
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseSupportTableViewCell" , for: indexPath) as! SupportTableViewCell
        return cell
    }
    
    
}
