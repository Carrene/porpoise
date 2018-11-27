//
//  PhoneConfirmationViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 8/27/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class PhoneConfirmationViewController: UIViewController,PhoneConfirmationViewProtocol,UITextFieldDelegate {
    
    @IBOutlet var viewChangeNumber: UIView!
    @IBOutlet var textFieldCode: UITextField!
    @IBOutlet var viewCode: UIView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var labelChangeNumber: UILabel!
    @IBOutlet var labelCounter: UILabel!
    @IBOutlet var NavigationItemTitle: UINavigationItem!
    var presenter:PhoneConfirmationPresenter?
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneConfirmationPresenter(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initUIComponent()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setPhoneNumber(phone:String) {
        self.phoneNumber = phone
    }
    
    func initUIComponent() {
        labelTitle.font = UIHelper.iranSanseBold(size: 16)
        viewCode.layer.cornerRadius = 10
        viewChangeNumber.layer.cornerRadius = 10
        labelPhone.font = UIHelper.iranSanseMedium(size: 16)
        labelCounter.font = UIHelper.iranSanseBold(size: 16)
        labelChangeNumber.font = UIHelper.iranSanseBold(size: 16)
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 10, width: 20, height: 11))
        iconView.image = R.image.key()
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        textFieldCode.leftView = iconContainerView
        textFieldCode.leftViewMode = .always
        textFieldCode.font = UIHelper.iranSanseBold(size: 20)
        textFieldCode.delegate = self
        labelPhone.text = phoneNumber
        labelChangeNumber.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        labelChangeNumber.addGestureRecognizer(tap)
        
    }
    
    @objc func dismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"۰۱۲۳۴۵۶۷۸۹").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func onTfPhoneEditDidChanged(_ sender: UITextField) {
        if textFieldCode.text != "" {
            //self.barButtonItemConfirm.isEnabled = true
        }
        else {
            //self.barButtonItemConfirm.isEnabled = false
        }
    }
    
    @IBAction func onConfirm(_ sender: UIBarButtonItem) {
        if textFieldCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(phone: self.phoneNumber, activationCode: textFieldCode.text!)
        }
    }
    
    func showBadRequestError() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_activation_code_is_not_valid(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func showSSMNotAvailable() {
        UIHelper.showSpecificSnackBar(message: R.string.localizable.sb_SSM_is_not_available(), color: R.color.errorColor()!, duration: .middle)
    }
    
    func segue() {
        //performSegue
    }
    
    @IBAction func onDoneKeyboard(_ sender: UITextField) {
        if textFieldCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(phone: self.phoneNumber, activationCode: textFieldCode.text!)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        navigationController?.navigationBar.backIndicatorImage = R.image.arrowLeft()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
