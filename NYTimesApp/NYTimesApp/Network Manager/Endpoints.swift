//
//  Endpoints.swift
//  NYTimesApp
//
//  Created by Arvind on 27/06/22.
//

import UIKit

enum Endpoints {
    static let base = "https://api.nytimes.com/"
    static let apiKey = "ZOyC8fSalGYf7yrPUGKRAKej1UVTtxfI"
    
    case mostPopular
    
    var string: String {
        switch self {
        case .mostPopular: return Endpoints.base + "svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=" + Endpoints.apiKey
        
        }
    }
}
