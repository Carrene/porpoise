
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
