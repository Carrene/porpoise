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
    
    public static let BIND_PATH = "phones"
    public static let CLAIM_PATH = "phones"
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
    
    private init() {
        alamofire = Alamofire.SessionManager.default
        alamofire.adapter = RequestInterceptor()
    }
    
    public static func newUrlComponentsInstance() -> NSURLComponents {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = Bundle.main.infoDictionary!["Web service scheme"] as? String
        urlComponents.host = Bundle.main.infoDictionary!["Web service host"] as? String
//        urlComponents.port = NSNumber(value: Int(Bundle.main.infoDictionary!["Web service port"] as! String)!)
        urlComponents.path = "/apiv\(Bundle.main.infoDictionary!["Web service version"] as! String)"
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
