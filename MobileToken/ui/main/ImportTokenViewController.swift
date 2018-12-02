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
        textViewSmsCode.font = R.font.iranSansMobile(size: 16)
        textViewAtmCode.font = R.font.iranSansMobile(size: 16)
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 8
    }

    @IBAction func onButtonAddCode(_ sender: UIButton) {
    }
    
}
