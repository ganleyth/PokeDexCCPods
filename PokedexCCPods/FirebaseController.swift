//
//  FirebaseController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseController {
    
    static let shared = FirebaseController()
    let auth = Auth.auth()
    
    func createUserWith(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            completion(user, error)
        }
    }
}

