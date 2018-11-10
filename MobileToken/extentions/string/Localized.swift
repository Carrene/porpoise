//
//  Localized.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/19/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation

extension String{
    
    func localized()->String{
        return NSLocalizedString(self, comment: "")
    }
}
