// 

import Foundation
import UIKit



class LatestUpdatesTableAdapter:NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var dataSource = 9
    var sender:LatestUpdatesViewController?
    
    init(sender:LatestUpdatesViewController) {
        self.sender = sender
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reuseUpdatesTableviewCell, for: indexPath) as! UITableViewCell
        tableView.allowsSelection = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
    
}
