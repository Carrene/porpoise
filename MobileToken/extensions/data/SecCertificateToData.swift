import Foundation
public extension SecCertificate {
    public var data: Data {
        return SecCertificateCopyData(self) as Data
    }
}
