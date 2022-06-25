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

    // MARK: - API Calling
    func getMostPopularNews(completion: @escaping (String?, Bool) -> Void) {
        HTTPClient.APIModelRequest(MostPopular.self, Endpoints.mostPopular.string) { response in
            self.results = response.results
            completion(nil, true)

        } failure: { error in
            completion(error.localizedDescription, false)

        }
    }
}
