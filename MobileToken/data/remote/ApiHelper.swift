//
//  ApiHelper.swift
//  alpha
//
//  Created by Arash Foumani on 7/2/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class ApiHelper {
    
    public static let BIND_PATH = "devices"
    public static let CLAIM_PATH = "devices"
    public static let SESSIONS_PATH = "sessions"
    
    public static let CLIENTS_PATH = "clients"
    
    public static let BIND_VERB = "BIND"
    public static let CLAIM_VERB = "CLAIM"
    public static let SET_EMAIL_VERB = "SET"
    public static let LIST_VERB = "LIST"
    public static let GET_VERB = "GET"
    public static let UPDATE_VERB = "UPDATE"
    
    public static let TAKE_QUERY_NAME = "take"
    public static let SKIP_QUERY_NAME = "skip"

    
    var alamofire: SessionManager!
    public var jwtPersistable: JwtPersistable = UserDefaultsJwtPersistor()
    
    fileprivate var requestInterceptor: RequestInterceptor = RequestInterceptor()
    
    static let instance: ApiHelper = {
        let instance = ApiHelper()
        return instance
    }()
    
    //TODO(Fateme): Remove this in release mode
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
        //TODO(Fateme) Get this prarameters from bundle
        let urlComponents = NSURLComponents()
//        urlComponents.scheme = Bundle.main.infoDictionary!["WEB_SERVICE_SCHEME"] as? String
//        urlComponents.host = Bundle.main.infoDictionary!["WEB_SERVICE_HOST"] as? String
//        urlComponents.port = NSNumber(value: Int(Bundle.main.infoDictionary!["WEB_SERVICE_PORT"] as! String)!)
//        urlComponents.path = "/apiv\(Bundle.main.infoDictionary!["WEB_SERVICE_VERSION"] as! String)"
        urlComponents.scheme = "https"
        urlComponents.host = "192.168.1.57"
        urlComponents.port=443
        urlComponents.path = "/apiv1"
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
