import Foundation
import UIKit

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : [String] ) {
        
        let attributedString = NSMutableAttributedString.init(string: fullText)
        for highlightedWord in changeText {
            let textRange = (fullText as NSString).range(of: highlightedWord)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: R.color.secondary()!,NSAttributedString.Key.font: UIHelper.getFont(size: 14)], range: textRange)
        }
        self.attributedText = attributedString
    }
}
