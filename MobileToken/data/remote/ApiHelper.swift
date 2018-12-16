import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

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
    #warning("Remove server trust this in release mode")
    
    private static var Manager : Alamofire.SessionManager = {
        // Create the server trust policies
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
