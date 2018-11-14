//
//  PasswordHintTableAdapter.swift
//  alpha
//
//  Created by Fateme' Kazemi on 5/20/1397 AP.
//  Copyright © 1397 Nuesoft. All rights reserved.
//

import Foundation
import UIKit

class PasswordHintTableAdapter: NSObject,UITableViewDataSource,UITableViewDelegate{
    
    var hintDataSource : [String:Bool]?
    var tableView : UITableView?
    
    override init() {
    }
    
    func setDataSource(hintDataSource:[String:Bool]) {
        
        self.hintDataSource = hintDataSource
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.passwordHintTableViewCell.identifier, for: indexPath) as! PasswordHintTableViewCell
        tableView.rowHeight = 25
        var hintArray = Array(hintDataSource!.keys)
        cell.lbHint.text = hintArray[indexPath.row]
        
        if (Array(hintDataSource!.values)[indexPath.row]) {
            
            cell.imgCheck.image =  R.image.passwordHintOk()
        }
        else {
            
            cell.imgCheck.image =  R.image.passwordHintNotOk()
        }
        return cell
    }
}
