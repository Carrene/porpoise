//
//  File.swift
//  MobileToken
//
//  Created by hamed akhlaghi on 8/12/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import Foundation
import UIKit
class ProgressLabel: UIView {
    
    var progressBarColor = UIColor(red:108.0/255.0, green:200.0/255.0, blue:226.0/255.0, alpha:1.0)
    var textColor = UIColor.white
    var font = UIFont.boldSystemFont(ofSize: 42)
    
    
    var progress: Float = 0 {
        didSet {
            progress = Float.minimum(100.0, Float.maximum(progress, 0.0))
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        // Set up environment.
        let size = self.bounds.size
        
        // Prepare progress as a string.
        let progressMessage = NSString(format:"%d %%", Int(progress))
        var attributes: [NSAttributedString.Key:Any] = [ NSAttributedString.Key.font : font ]
        let textSize = progressMessage.size(withAttributes: attributes)
        let progressX = ceil(CGFloat(progress) / 100 * size.width)
        let textPoint = CGPoint(x: ceil((size.width - textSize.width) / 2.0), y: ceil((size.height - textSize.height) / 2.0))
        
        // Draw background + foreground text
        progressBarColor.setFill()
        context.fill(self.bounds)
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        progressMessage.draw(at: textPoint, withAttributes: attributes)
        
        // Clip the drawing that follows to the remaining progress' frame.
        context.saveGState()
        let remainingProgressRect = CGRect(x: progressX, y: 0.0, width: size.width - progressX, height: size.height)
        context.addRect(remainingProgressRect)
        context.clip()
        
        // Draw again with inverted colors.
        textColor.setFill()
        context.fill(self.bounds)
        attributes[NSAttributedString.Key.foregroundColor] = progressBarColor
        progressMessage.draw(at: textPoint, withAttributes: attributes)
        
        context.restoreGState()
    }
}
