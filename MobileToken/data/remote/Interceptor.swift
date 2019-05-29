import Foundation
import Alamofire
import AlamofireObjectMapper

class RequestInterceptor: RequestAdapter {
    
    public var jwtPersistable: JwtPersistable? = UserDefaultsJwtPersistor()
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = Bundle.main.infoDictionary?["Web service token"] as! String
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        if let jwt = ApiHelper.instance.jwtPersistable.get() {
            urlRequest.addValue("Bearer " + jwt, forHTTPHeaderField: "Authorization")
        }
        urlRequest.timeoutInterval = 10
        return urlRequest
    }
}

extension DataRequest {
    func intercept() -> Self {
        let serializedResponse = DataResponseSerializer<Any?> { request, response, data, error in
            guard error == nil else {
                if let verb = request?.httpMethod {
                    Logger.instance.logEvent(event: verb.uppercased(), parameters: ["result": "\(error?.localizedDescription ?? "Not Handled")" as NSObject])
                }
                return .failure(error!)
            }
            if let verb = request?.httpMethod, let statusCode = response?.statusCode {
                Logger.instance.logEvent(event: verb.uppercased(), parameters: ["result": statusCode as NSObject])
            }
            return .success(data)
        }
        return response(responseSerializer: serializedResponse) { _ in }
    }
}
