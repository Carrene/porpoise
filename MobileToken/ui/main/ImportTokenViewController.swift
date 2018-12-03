//
//  ImportTokenViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/11/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit
import XLActionController

class ImportTokenViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var viewCard: CardCellXibView!
    @IBOutlet var textViewAtmCode: UITextView!
    @IBOutlet var labelAtmCode: UILabel!
    @IBOutlet var textViewSmsCode: UITextView!
    @IBOutlet var labelSmsCode: UILabel!
    @IBOutlet var buttonAddCode: UIButton!
    let actionController = MobileTokenActionSheetController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
        initActionSheet()
        
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
    
    func initActionSheet() {
        var editCardAction = Action(ActionData(title: "ویرایش نام کارت", image: R.image.cardEdit()!), style: .default, handler: { action in })
        var deleteCardAction = Action(ActionData(title: "حذف کارت", image: R.image.cardDelete()!), style: .default, handler: { action in })
        actionController.addAction(editCardAction)
        actionController.addAction(deleteCardAction)
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
        present(actionController, animated: true, completion: nil)

    }
    
}

