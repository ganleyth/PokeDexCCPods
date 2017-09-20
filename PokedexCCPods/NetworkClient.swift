//
//  NetworkClient.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation

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
                             completion: @escaping (Data?, Error?) -> Void) {
        
        guard let completeURL = url(byAdding: parameters, to: baseURL) else {
            NSLog("Could not successfully build complete URL for data task")
            completion(nil, nil)
            return
        }
        
        var urlRequest = URLRequest(url: completeURL)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = httpBody
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            completion(data, error)
        }
        
        dataTask.resume()
    }
    
    static func url(byAdding parameters: [String: String]?, to baseURL: URL) -> URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents?.url
    }
}
