//
//  NetworkManager.swift
//  NYTimesAppTests
//
//  Created by Arvind on 25/06/22.
//

import UIKit
import Alamofire
@testable import NYTimesApp

class NetworkManagerMock: NetworkManager {
    @discardableResult
    override class func apiModelRequest<T: Decodable>(_ model:T.Type, _ url: String, _ httpMethod: HTTPMethod = .get, _ header: Dictionary<String, String>? = nil, _ parameter: [String: AnyObject]? = nil, success:@escaping (T) -> Void, failure:@escaping (Error) -> Void) -> DataRequest? {
        
        let request = AF.request(url, method: httpMethod, parameters: parameter, encoding: JSONEncoding.default, headers: HTTPHeaders(header ?? [:])).response { response in
            
            if response.error != nil {
                failure(response.error!)
                
            } else {
                guard let data = response.data else {
                    failure(self.parseError(APIError.message))
                    return
                }
                
                do {
                    let responseModel = try JSONDecoder().decode(model, from: data)
                    success(responseModel)
                    
                } catch let jsonError {
                    failure(jsonError)
                }
            }
        }
        
        return request
    }
    
    class fileprivate func parseError(_ error: String) -> Error {
         let error = NSError(domain:APIError.domain, code:APIError.code, userInfo:[ NSLocalizedDescriptionKey: error])
         print("handleParseError: \(error.localizedDescription)")
         
         return error
     }
}
