//
//  CoreTelephonyHelper.swift
//  Aras
//
//  Created by hamed akhlaghi on 6/15/19.
//  Copyright © 2019 com.tosan.mobiletoken. All rights reserved.
//

import Foundation
import CoreTelephony

class CoreTelephonyHelper {
    
    static func isIrCardAvailable( code: String)  -> Bool {
        if #available(iOS 12.0, *) {
            var isIrCardAvailable = false
            let info = CTTelephonyNetworkInfo()
            
            let carrier = info.serviceSubscriberCellularProviders
            
            for (_, value) in carrier ?? [String: CTCarrier]() {
                if value.isoCountryCode == code {
                    isIrCardAvailable = true
                }
            }
            return isIrCardAvailable
        } else {
            return true
        }
    }
    
    static func isSimCardAvailavle() -> Bool {
        if #available(iOS 12.0, *) {
            let info = CTTelephonyNetworkInfo()
            let carrier = info.serviceSubscriberCellularProviders
            
            return carrier?.count ?? 0 > 0
        } else {
            return true
        }
    }
}

