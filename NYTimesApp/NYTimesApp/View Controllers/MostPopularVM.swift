//
//  MostPopularVM.swift
//  NYTimesApp
//
//  Created by Arvind on 22/06/22.
//

import UIKit

protocol MostPopularInput {
    var results: [MostResults]? { get set }
}

protocol MostPopularOutput {
    func getMostPopularNews(completion: @escaping (String?, Bool) -> Void)
}

protocol MostPopularProtocol: MostPopularInput, MostPopularOutput {}

final class MostPopularVM: MostPopularProtocol {
    
    // MARK: - Properties
    var results: [MostResults]?
    var httpClient: HTTPClientProtocol!
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }

    // MARK: - API Calling
    func getMostPopularNews(completion: @escaping (String?, Bool) -> Void) {
        
        httpClient.apiModelRequest(MostPopular.self, Endpoints.mostPopular.stringValue, .get, nil, nil) { [weak self ] response in
            guard let self = self else { return }
            self.results = response.results
            completion(nil, true)

        } failure: { error in
            completion(error.localizedDescription, false)

        }
    }
}
