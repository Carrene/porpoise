import Foundation
import UIKit

protocol HelpTableAdapterProtocol {
    func selectedRow(index:Int)
}

class HelpTableViewAdapter : NSObject,UITableViewDelegate,UITableViewDataSource {
    
    private var dataSource : [String]?
    private var sender:HelpViewController?
    private var helpAdapterProtocol:HelpTableAdapterProtocol?
    
    func setDataSource(dataSource:[String]) {
        self.dataSource = dataSource
    }
    
    func setDelegate(delegate:HelpTableAdapterProtocol) {
        self.helpAdapterProtocol = delegate
    }
    
    init(sender:HelpViewController) {
        self.sender = sender
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseHelpCell.identifier, for: indexPath) as! HelpTableViewCell
        cell.labelQuestion?.textColor = R.color.buttonColor()
        cell.labelQuestion.text = dataSource![indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.helpAdapterProtocol?.selectedRow(index: indexPath.row)
    }
    
    
    
    
    
    
    
    
    
    
    
}
