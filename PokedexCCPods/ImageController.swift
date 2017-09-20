//
//  ImageController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static func fetchImage(atURL url: URL, with completion: @escaping (UIImage?) -> Void) {
        NetworkClient.performDataTaskWith(baseURL: url, httpMethod: .get) { (data, error) in
            var image: UIImage? = nil
            defer { completion(image) }
            
            if let error = error { NSLog("Error fetching image: \(error.localizedDescription)"); return }
            guard let data = data else { NSLog("Data returned from image fetch is nil"); return }
            
            image = UIImage(data: data)
        }
    }
}
