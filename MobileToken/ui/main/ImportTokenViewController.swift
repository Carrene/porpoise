//
//  ImportTokenViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/11/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class ImportTokenViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textViewAtmCode: UITextView!
    @IBOutlet var labelAtmCode: UILabel!
    @IBOutlet var textViewSmsCode: UITextView!
    @IBOutlet var labelSmsCode: UILabel!
    @IBOutlet var buttonAddCode: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
        
        
    }
    
    func initUIComponent() {
        buttonAddCode.layer.cornerRadius = 10
        viewCard.layer.cornerRadius = 10
        textViewAtmCode.layer.cornerRadius = 10
        textViewSmsCode.layer.cornerRadius = 10
        textViewAtmCode.delegate = self
        textViewSmsCode.delegate = self
        textViewSmsCode.font = R.font.iranSansMobile(size: 16)
        textViewAtmCode.font = R.font.iranSansMobile(size: 16)
        initBankCard()
    }
    
    func initBankCard() {
        viewCard.backgroundColor = R.color.ayandehColor()
        viewCard.imageLogo.image = R.image.bankAyandehLogo()
        viewCard.labelBankName.text = "بانک آینده"
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == textViewAtmCode {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 9
        }
        else {
            return true
        }
    }

    @IBAction func onButtonAddCode(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let backView = optionMenu.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 0
        backView?.backgroundColor = R.color.primaryLight()
        // 2
        let editCardAction = UIAlertAction(title: "ویرایش نام کارت", style: .default)
        let deleteCardAction = UIAlertAction(title: "حذف کارت", style: .default)
        let deleteCode = UIAlertAction(title:"حذف رمز", style: .default)
        // 3
        //let cancelAction = UIAlertAction(title: "انصراف", style: .cancel)
        // 4
        optionMenu.addAction(editCardAction)
        optionMenu.addAction(deleteCardAction)
        //optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

extension UIAlertController{
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.tintColor = R.color.primaryLight()
        //self.view.tintColor = R.color.buttonColor()
        
    }
}
