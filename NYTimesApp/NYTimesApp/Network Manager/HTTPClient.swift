//
//  API.swift
//  NYTimesApp
//
//  Created by Arvind on 22/06/22.
//

import UIKit
import Alamofire

let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")

protocol HTTPClientProtocol {
    @discardableResult
    func apiModelRequest<T:Decodable>(_ model:T.Type, _ url: String, _ httpMethod: HTTPMethod, _ header: Dictionary<String, String>?, _ parameter: [String: AnyObject]?, success:@escaping (T) -> Void, failure:@escaping (Error) -> Void) -> DataRequest?
}

class HTTPClient: HTTPClientProtocol {

    @discardableResult
    func apiModelRequest<T:Decodable>(_ model: T.Type, _ url: String, _ httpMethod: HTTPMethod, _ header: Dictionary<String, String>?, _ parameter: [String : AnyObject]?, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) -> DataRequest? {
        
        if !(reachabilityManager!.isReachable) {
            print("reachabilityManager is not Connected")
            failure(parseError("No Internet Connection"))
            return nil
        }
        
        let request = AF.request(url, method: httpMethod, parameters: parameter, encoding: JSONEncoding.default, headers: HTTPHeaders(header ?? [:])).response { response in
            
            if response.error != nil {
                failure(response.error!)
                
            } else {
                if 200..<300 ~= (response.response?.statusCode ?? 0) {
                    guard let data = response.data else { failure(self.parseError(APIError.message)); return }
                    do {
                        let responseModel = try JSONDecoder().decode(model, from: data)
                        success(responseModel)
                        
                    } catch let jsonError {
                        failure(jsonError)
                    }
                }
            }
        }
        
        return request
    }
    
   fileprivate func parseError(_ error: String) -> Error {
        let error = NSError(domain:APIError.domain, code:APIError.code, userInfo:[ NSLocalizedDescriptionKey: error])
        print("handleParseError: \(error.localizedDescription)")
        
        return error
    }
}

struct APIError {
    static let domain = "ParseError"
    static let message = "Unable to parse data"
    static let code = Int(UInt8.max)
}

struct APIHeader {
    static let contentType = "Content-Type"
    static let Authorization = "Authorization"
    static let applicationFormURLEncoded = "application/x-www-form-urlencoded"
    static let applicationJson = "application/json"
    static let multipartFormData = "multipart/form-data"
}

enum Endpoints {
    static let base = "https://api.nytimes.com/"
    static let apiKey = "ZOyC8fSalGYf7yrPUGKRAKej1UVTtxfI"
    
    case mostPopular
    
    var stringValue: String {
        switch self {
        case .mostPopular: return Endpoints.base + "svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=" + Endpoints.apiKey
        
        }
    }
}
