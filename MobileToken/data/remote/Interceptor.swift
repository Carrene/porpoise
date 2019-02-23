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
            guard error == nil else { return .failure(error!) }
            if let verb = request?.httpMethod,
                let statusCode = response?.statusCode,
                verb == ApiHelper.BIND_VERB && 200 <= statusCode && statusCode < 300,
                let data = data,
                let value = try? JSONSerialization.jsonObject(with: data) as! [String : Any?] ,
                let jwt = value["token"] as? String {
                _ = ApiHelper.instance.jwtPersistable.save(jwt: jwt)
            }
            if let jwt = response?.allHeaderFields["X-New-JWT-Token"] as? String {
                _ = ApiHelper.instance.jwtPersistable.save(jwt: jwt)
            }
            return .success(data)
        }
        return response(responseSerializer: serializedResponse) { _ in }
    }
}
