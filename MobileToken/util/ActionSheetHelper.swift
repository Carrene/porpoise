//
//  ActionSheetHelper.swift
//  MobileToken
//
//  Created by Fateme' Kazemi on 9/11/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import XLActionController

public class MobileTokenActionSheetController: ActionController<UICollectionViewCell, Any, UICollectionReusableView, Any, UICollectionReusableView, Any> {
    
    // override init in order to customize behavior and animations
    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // customizing behavior and present/dismiss animations
        settings.behavior.hideOnScrollDown = false
        settings.animation.scale = nil
        settings.animation.present.duration = 0.6
        settings.animation.dismiss.duration = 0.5
        settings.animation.dismiss.options = .curveEaseIn
        settings.animation.dismiss.offset = 30
        
        // providing a specific collection view cell which will be used to display each action, height parameter expects a block that returns the cell height for a particular action.
        cellSpec = .nibFile(nibName: "PeriscopeCell", bundle: Bundle(for: PeriscopeCell.self), height: { _ in 60})
        // providing a specific view that will render each section header.
        sectionHeaderSpec = .cellClass(height: { _ in 5 })
        // providing a specific view that will render the action sheet header. We calculate its height according the text that should be displayed.
        headerSpec = .cellClass(height: { [weak self] (headerData: String) in
            guard let me = self else { return 0 }
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: me.view.frame.width - 40, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.font = .systemFontOfSize(17.0)
            label.text = headerData
            label.sizeToFit()
            return label.frame.size.height + 20
        })
        
        // once we specify the views, we have to provide three blocks that will be used to set up these views.
        // block used to setup the header. Header view and the header are passed as block parameters
        onConfigureHeader = { [weak self] header, headerData in
            guard let me = self else { return }
            header.label.frame = CGRect(x: 0, y: 0, width: me.view.frame.size.width - 40, height: CGFloat.greatestFiniteMagnitude)
            header.label.text = headerData
            header.label.sizeToFit()
            header.label.center = CGPoint(x: header.frame.size.width  / 2, y: header.frame.size.height / 2)
        }
        // block used to setup the section header
        onConfigureSectionHeader = { sectionHeader, sectionHeaderData in
            sectionHeader.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        }
        // block used to setup the collection view cell
        onConfigureCellForAction = { [weak self] cell, action, indexPath in
            cell.setup(action.data, detail: nil, image: nil)
            cell.separatorView?.isHidden = indexPath.item == self!.collectionView.numberOfItems(inSection: indexPath.section) - 1
            cell.alpha = action.enabled ? 1.0 : 0.5
            cell.actionTitleLabel?.textColor = action.style == .destructive ? UIColor(red: 210/255.0, green: 77/255.0, blue: 56/255.0, alpha: 1.0) : UIColor(red: 0.28, green: 0.64, blue: 0.76, alpha: 1.0)
        }
    }
}
