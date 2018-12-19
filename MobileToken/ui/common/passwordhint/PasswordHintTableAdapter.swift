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
    
//    var hintDataSource : [String:Bool]?
    var tableView : UITableView?
    var hintDataSource = [R.string.localizable.enter_at_least_eight_characters():false,R.string.localizable.enter_at_least_one_capital_letter():false,R.string.localizable.enter_at_least_one_digit():false,R.string.localizable.enter_at_least_one_special_character():false]
    
    private var i = 0
    
    override init() {
    }
    
    
    func isCompleted() -> Bool {
    
        return i >= 4
    }
    
    func resetValidation() {
    
        i = 0
    }
    
    public func setMinimumLengthValid(isValid: Bool) {
        hintDataSource.updateValue(isValid, forKey: R.string.localizable.enter_at_least_eight_characters())
        if (isValid) {
            i += 1
        } else {
            tableView?.reloadData()
            i -= 1
        }
        tableView?.reloadData()
    }
    
    public func setCapitalLetterValid(isValid: Bool) {
        hintDataSource.updateValue(isValid, forKey: R.string.localizable.enter_at_least_one_capital_letter())
        if (isValid) {
            i += 1
            
        } else {
            i -= 1
        }
        tableView?.reloadData()
    }
    
    public func setSpecialCharacterValid(isValid: Bool) {
    
        hintDataSource.updateValue(isValid, forKey: R.string.localizable.enter_at_least_one_special_character())
        if (isValid) {
            i += 1
            
        } else {
            i -= 1
        }
        tableView?.reloadData()
    }
    
    public func setHasDigit(isValid: Bool) {
    
        hintDataSource.updateValue(isValid, forKey: R.string.localizable.enter_at_least_one_digit())
        if (isValid) {
            i += 1
            
        } else {
            i -= 1
        }
        tableView?.reloadData()
    }
//    func setDataSource(hintDataSource:[String:Bool]) {
//
//        self.hintDataSource = hintDataSource
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.passwordHintTableViewCell.identifier, for: indexPath) as! PasswordHintTableViewCell
        tableView.rowHeight = 30
        var hintArray = Array(hintDataSource.keys)
        cell.lbHint.text = hintArray[indexPath.row]
        tableView.separatorColor = UIColor.clear
        if (Array(hintDataSource.values)[indexPath.row]) {
            cell.imgCheck.image =  R.image.passwordHintOk()
        }
        else {
            cell.imgCheck.image =  R.image.passwordHintNotOk()
        }
        return cell
    }
}
