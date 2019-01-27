import Foundation
import UIKit

protocol HelpTableAdapterProtocol {
    func selectedRow()
}

class HelpTableViewAdapter : NSObject,UITableViewDelegate,UITableViewDataSource {
    
    private var dataSource : [String]?
    
    private var sender:HelpViewController?
    
    func setDataSource(dataSource:[String]) {
        self.dataSource = dataSource
    }
    
    init(sender:HelpViewController) {
        self.sender = sender
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseHelpCell.identifier, for: indexPath) as! HelpTableViewCell
        cell.textLabel?.text = dataSource![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
