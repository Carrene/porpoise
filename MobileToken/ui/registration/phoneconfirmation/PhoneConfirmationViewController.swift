//
//  PhoneConfirmationViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 8/27/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class PhoneConfirmationViewController: UIViewController,PhoneConfirmationViewProtocol,UITextFieldDelegate {
    
    @IBOutlet var vChangeNumber: UIView!
    @IBOutlet var tfCode: UITextField!
    @IBOutlet var vCode: UIView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbPhone: UILabel!
    @IBOutlet var lbChangeNumber: UILabel!
    @IBOutlet var lbCounter: UILabel!
    @IBOutlet var barBtConfirm: UIBarButtonItem!
    @IBOutlet var navigationTitle: UINavigationItem!
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
        lbTitle.font = UIHelper.iranSanseBold(size: 16)
        vCode.layer.cornerRadius = 10
        vChangeNumber.layer.cornerRadius = 10
        lbPhone.font = UIHelper.iranSanseMedium(size: 16)
        lbCounter.font = UIHelper.iranSanseBold(size: 16)
        lbChangeNumber.font = UIHelper.iranSanseBold(size: 16)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 11))
        imageView.backgroundColor = R.color.primaryDark()
        let image = R.image.key()
        imageView.image = image
        tfCode.leftView = imageView
        tfCode.leftViewMode = .always
        tfCode.font = UIHelper.iranSanseBold(size: 20)
        tfCode.delegate = self
        barBtConfirm.setTitleTextAttributes([ NSAttributedString.Key.font:R.font.iranSansMobileBold(size: 14)!], for: .normal)
        lbPhone.text = phoneNumber
        
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
    
    @IBAction func onConfirm(_ sender: UIBarButtonItem) {
        if tfCode.text != "" && self.phoneNumber != "" {
            presenter?.bind(phone: self.phoneNumber, activationCode: tfCode.text!)
        }
    }
    
    func showBadRequestError() {
        SnackBarHelper.init(message: "Activation code is not valid", duration: .middle).show()
    }
    
    func showSSMNotAvailable() {
        SnackBarHelper.init(message: "SSM is not available", duration: .middle).show()
    }
    
    func segue() {
        //performSegue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        navigationController?.navigationBar.backIndicatorImage = R.image.arrowLeft()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    

}
