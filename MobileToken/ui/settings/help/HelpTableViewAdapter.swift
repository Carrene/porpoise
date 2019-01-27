import Foundation
import UIKit

class HelpTableViewAdapter : NSObject,UITableViewDelegate,UITableViewDataSource {
    
    private var dataSource: [String]?
    private var sender:HelpViewController?
    
    func setDataSource(dataSource:[String]) {
        self.dataSource = dataSource
    }
    
    init(sender:HelpViewController) {
        self.sender = sender
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseHelpCell.identifier, for: indexPath) as! HelpTableViewCell
        cell.textLabel?.text = "چطور میتوانم بانک جدید اضافه کنم؟"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.font = R.font.iranSansMobile(size: 16)
        cell.textLabel?.textColor = R.color.buttonColor()
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
