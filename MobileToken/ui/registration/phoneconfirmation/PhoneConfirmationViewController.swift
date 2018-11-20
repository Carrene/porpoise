//
//  PhoneConfirmationViewController.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 8/27/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import UIKit

class PhoneConfirmationViewController: UIViewController {

    @IBOutlet var vChangeNumber: UIView!
    @IBOutlet var tfCode: UITextField!
    @IBOutlet var vCode: UIView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbPhone: UILabel!
    @IBOutlet var lbChangeNumber: UILabel!
    @IBOutlet var lbCounter: UILabel!
    @IBOutlet var barBtConfirm: UIBarButtonItem!
    @IBOutlet var navigationTitle: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponent()
        // Do any additional setup after loading the view.
    }
    
    func initUIComponent() {
        lbTitle.font = UIHelper.iranSanseBold(size: 16)
        vCode.layer.cornerRadius = 10
        vChangeNumber.layer.cornerRadius = 10
        lbPhone.font = UIHelper.iranSanseMedium(size: 16)
        lbCounter.font = UIHelper.iranSanseBold(size: 16)
        lbChangeNumber.font = UIHelper.iranSanseBold(size: 16)
        let imageView = UIImageView(frame: CGRect(x: 20, y: 15, width: 20, height: 11))
        imageView.backgroundColor = R.color.primaryDark()
        let image = R.image.key()
        imageView.image = image
        tfCode.leftView = imageView
        tfCode.leftViewMode = .always
        tfCode.font = UIHelper.iranSanseBold(size: 20)
        barBtConfirm.setTitleTextAttributes([ NSAttributedString.Key.font:R.font.iranSansMobileBold(size: 14)!], for: .normal)
    
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        navigationController?.navigationBar.backIndicatorImage = R.image.arrowLeft()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    

}