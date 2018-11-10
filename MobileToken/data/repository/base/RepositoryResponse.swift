//
//  RepositoryResponse.swift
//  alpha
//
//  Created by Arash Foumani on 6/27/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation
import Alamofire

struct RepositoryResponse<Model> {
    public var value: Model?
    public var restDataResponse: DataResponse<Model>?
    public var error: Error?
    
    init(value: Model? = nil, restDataResponse: DataResponse<Model>? = nil, error: Error? = nil) {
        self.value = value
        self.restDataResponse = restDataResponse
        self.error = error
    }
}
