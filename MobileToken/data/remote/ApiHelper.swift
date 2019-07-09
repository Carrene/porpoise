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

        let man = Alamofire.SessionManager()
        man.delegate.sessionDidReceiveChallenge = { session, challenge in

            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                let host = challenge.protectionSpace.host
                let selfSigned = Bundle.main.infoDictionary?["Web service self signed"] as! String
                
                if let serverTrust = challenge.protectionSpace.serverTrust  {
                    if selfSigned == "YES" {
                        let serverTrustPolicy = ServerTrustPolicy.performDefaultEvaluation(validateHost: false)
                        disposition = .useCredential
                        credential = URLCredential(trust: serverTrust)
                        return (disposition, credential)
                    }
                    
                    let serverTrustPolicy = ServerTrustPolicy.performDefaultEvaluation(validateHost: true)
                    if serverTrustPolicy.evaluate(serverTrust, forHost: host) {
                        disposition = .useCredential
                        credential = URLCredential(trust: serverTrust)
                    } else {
                        disposition = .cancelAuthenticationChallenge
                        return (disposition, credential)
                    }

                    let fingerPrints = [
                        "9B2801E488DF6C74136D183340CD5B040CFB406665A9DA6B6F8A1A4F83A4AEF4".lowercased(),
                        "129FB5DE501E24041CD14A81075FD1CDE257408D4A353E636912E38BDDA2D3FB".lowercased(),
                        "5C58468D55F58E497E743982D2B50010B6D165374ACF83A7D4A32DB768C4408E".lowercased()
                    ]

                    for index in 0..<SecTrustGetCertificateCount(serverTrust) {
                        let cer = SecTrustGetCertificateAtIndex(serverTrust, index)
                        if let certificate = SecTrustGetCertificateAtIndex(serverTrust, index) {
                            let certData = certificate.data
                            let certHashByteArray = certData.sha256()
                            let certificateHexString = certHashByteArray.toHexString().lowercased()

                            if fingerPrints.contains(certificateHexString) {
                                return (disposition, credential)
                            }
                        }
                    }
                }
            }
            disposition = .cancelAuthenticationChallenge
            return (disposition, credential)
        }
        return man
    }()
    
    private init() {
        alamofire = ApiHelper.Manager
        alamofire.adapter = RequestInterceptor()
    }
    
    public static func newUrlComponentsInstance() -> NSURLComponents {
        let urlComponents = NSURLComponents()
        
        urlComponents.scheme = Bundle.main.infoDictionary?["Web service scheme"] as? String
        
        urlComponents.path = "/apiv\(Bundle.main.infoDictionary?["Web service version"] as! String)"
       
        urlComponents.host = Bundle.main.infoDictionary?["Web service host"] as? String
       
        urlComponents.port = NSNumber(value: Int(Bundle.main.infoDictionary?["Web service port"] as! String)!)
        
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
