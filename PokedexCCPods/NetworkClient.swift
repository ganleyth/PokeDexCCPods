//
//  NetworkClient.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClient {
    
    enum HTTPMethod: String {
        case get = "GET"
        case push = "PUSH"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    static func performDataTaskWith(baseURL: URL,
                             parameters: [String: String]? = nil,
                             httpMethod: HTTPMethod,
                             httpBody: Data? = nil,
                             completion: @escaping (DataResponse<Any>?) -> Void) {
        
        guard let completeURL = url(byAdding: parameters, to: baseURL) else { completion(nil); return }
        
        Alamofire.request(completeURL).responseJSON { (response) in
            completion(response)
        }
    }
    
    static func url(byAdding parameters: [String: String]?, to baseURL: URL) -> URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents?.url
    }
}
