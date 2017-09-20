//
//  Trainer.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation

struct Trainer {
    let username: String
    let password: String
    var capturedPokemon: [Pokemon] = []
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension Trainer {
    mutating func addCapturedPokemon(_ pokemon: Pokemon) {
        self.capturedPokemon.append(pokemon)
    }
}
