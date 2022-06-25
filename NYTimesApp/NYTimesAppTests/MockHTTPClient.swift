//
//  MockHttpClient.swift
//  NYTimesAppTests
//
//  Created by Arvind on 25/06/22.
//

import Foundation
import Alamofire
@testable import NYTimesApp

final class MockHTTPClient: HTTPClientProtocol, Mockable {
    @discardableResult
    func apiModelRequest<T: Decodable>(_ model: T.Type, _ url: String, _ httpMethod: HTTPMethod, _ header: Dictionary<String, String>?, _ parameter: [String : AnyObject]?, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) -> DataRequest? {
        success(loadJSON(filename: "MostPopular", type: T.self))
        return nil
    }
}
