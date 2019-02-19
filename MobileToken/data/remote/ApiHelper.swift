import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import Security

class ApiHelper {
    
    public static let BIND_PATH = "devices"
    public static let CLAIM_PATH = "devices"
    
    public static let BIND_VERB = "BIND"
    public static let CLAIM_VERB = "CLAIM"
    
    var alamofire: SessionManager!
    var jwtPersistable: JwtPersistable = UserDefaultsJwtPersistor()
    
    private var requestInterceptor: RequestInterceptor = RequestInterceptor()
    
    static let instance: ApiHelper = {
        let instance = ApiHelper()
        return instance
    }()
    
    private static var Manager : Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "192.168.1.57": .disableEvaluation
        ]
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
//        let man = Alamofire.SessionManager()
//        man.delegate.sessionDidReceiveChallenge = { session, challenge in
//            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
//            var credential: URLCredential?
//            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//                let host = challenge.protectionSpace.host
//
//                if let serverTrust = challenge.protectionSpace.serverTrust {
//                    let serverTrustPolicy = ServerTrustPolicy.performDefaultEvaluation(validateHost: true)
//                    if serverTrustPolicy.evaluate(serverTrust, forHost: host) {
//                        disposition = .useCredential
//                        credential = URLCredential(trust: serverTrust)
//                    } else {
//                        disposition = .cancelAuthenticationChallenge
//                        return (disposition, credential)
//                    }
//
//                    let fingerPrints = [
//                        "5C58468D55F58E497E743982D2B50010B6D165374ACF83A7D4A32DB768C4408E".lowercased(),
//                        "129FB5DE501E24041CD14A81075FD1CDE257408D4A353E636912E38BDDA2D3FB".lowercased(),
//                        "31E164412F51F75D6E97A5D5FF4E7E14CE2B470479D7A0986451C6B12BB9D4B7".lowercased()
//                    ]
//
//                    for index in 0..<SecTrustGetCertificateCount(serverTrust) {
//                        let cer = SecTrustGetCertificateAtIndex(serverTrust, index)
//                        if let certificate = SecTrustGetCertificateAtIndex(serverTrust, index) {
//                            let certData = certificate.data
//                            let certHashByteArray = certData.sha256()
//                            let certificateHexString = certHashByteArray.toHexString().lowercased()
//
//                            if fingerPrints.contains(certificateHexString) {
//                                return (disposition, credential)
//                            }
//                        }
//                    }
//                }
//            }
//            disposition = .cancelAuthenticationChallenge
//            return (disposition, credential)
//        }
        return man
    }()
    
    private init() {
        alamofire = ApiHelper.Manager
        alamofire.adapter = RequestInterceptor()
    }
    
    public static func newUrlComponentsInstance() -> NSURLComponents {
        let urlComponents = NSURLComponents()
        
        if let scheme = Bundle.main.infoDictionary!["WEB_SERVICE_SCHEME"] as? String {
            urlComponents.scheme = scheme
        }
        else {
            urlComponents.scheme = "https"
        }
        
        if let version = Bundle.main.infoDictionary!["WEB_SERVICE_VERSION"] as? String {
            urlComponents.path = "/apiv\(version)"
        }
        else {
            urlComponents.path = "/apiv1"
        }
        
        if let host = Bundle.main.infoDictionary!["WEB_SERVICE_HOST"] as? String {
            urlComponents.host = host
        }
        else {
            urlComponents.host = "192.168.1.57"
        }
        
        if let port = Bundle.main.infoDictionary!["WEB_SERVICE_PORT"] as? String {
            urlComponents.port = NSNumber(value: Int(port)!)
        }
        else {
            urlComponents.port = 443
        }
        
        return urlComponents
    }
    
    func stopTheRequests() {
        if #available(iOS 9.0, *) {
            Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
                tasks.forEach { $0.cancel() }
            }
        } else {
            Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
                sessionDataTask.forEach { $0.cancel() }
                uploadData.forEach { $0.cancel() }
                downloadData.forEach { $0.cancel() }
            }
        }
    }
}
