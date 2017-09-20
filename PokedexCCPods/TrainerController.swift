//
//  TrainerController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation

class TrainerController {
    static var currentTrainer: Trainer? = Trainer(username: "tom", password: "ganley")
    
    static func addCapturedPokemonToCurrentTrainer(pokemon: Pokemon) {
        currentTrainer?.addCapturedPokemon(pokemon)
    }
}
