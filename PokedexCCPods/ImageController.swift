//
//  ImageController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ImageController {
    
    static func fetchImage(atURL url: URL, with completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(url).responseData { (response) in
            guard let data = response.value else { completion(nil); return }
            let image = UIImage(data: data)
            completion(image)
        }
    }
}
