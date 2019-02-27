import Foundation
extension String {
    public var replacedArabicPersianDigitsWithEnglish: String {
        var str = self
        // For Arabic digits
        var map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        // For Persian digits
        map = ["۰": "0",
               "۱": "1",
               "۲": "2",
               "۳": "3",
               "۴": "4",
               "۵": "5",
               "۶": "6",
               "۷": "7",
               "۸": "8",
               "۹": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
}

