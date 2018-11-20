//
//  UserRestRepository.swift
//  alpha
//
//  Created by Arash Foumani on 7/2/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class UserRestRepository: UserRepositoryProtocol {
    
    func bind(user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        let urlComponents = ApiHelper.newUrlComponentsInstance()
        urlComponents.path = "\(urlComponents.path ?? "")/\(ApiHelper.BIND_PATH)"
        let url = urlComponents.url!
        let parameters: [String: Any?] =
        [
            "udid": user.udid,
            "phone": user.phone,
            "deviceName": user.deviceName,
            "activationCode": user.activationCode
        ]
        let json = try! JSONSerialization.data(withJSONObject: parameters)
        var request = URLRequest(url: url)
        request.httpBody = json
        request.httpMethod = ApiHelper.BIND_VERB
        ApiHelper.instance.alamofire.request(request).intercept().responseObject { (dataResponse: DataResponse<User>) in
            if let error = dataResponse.error {
                onDone?(RepositoryResponse(error: error))
                return
            }
            onDone?(RepositoryResponse(value: dataResponse.value, restDataResponse: dataResponse))
        }
    }
    
    func claim(user: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        let urlComponents = ApiHelper.newUrlComponentsInstance()
        urlComponents.path = "\(urlComponents.path ?? "")/\(ApiHelper.CLAIM_PATH)"
        // TODO: Take care of this unwrap
        let url = urlComponents.url!
        let parameters: [String: Any?] =
        [
            "phone": user.phone,
            "udid": user.udid
        ]
        let json = try! JSONSerialization.data(withJSONObject: parameters)
        var request = URLRequest(url: url)
        request.httpBody = json
        request.httpMethod = ApiHelper.CLAIM_VERB
        ApiHelper.instance.alamofire.request(request).intercept().responseObject { (dataResponse: DataResponse<User>) in
            if let error = dataResponse.error {
                onDone?(RepositoryResponse(error: error))
                return
            }
            onDone?(RepositoryResponse(value: dataResponse.value, restDataResponse: dataResponse))
        }
    }
    
    func update(_: User, onDone: ((RepositoryResponse<User>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func get(identifier: Int, onDone: ((RepositoryResponse<User>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
    
    func getAll(onDone: ((RepositoryResponse<[User]>) -> ())?) {
        onDone?(RepositoryResponse(error: UnsupportedOperationException()))
    }
}