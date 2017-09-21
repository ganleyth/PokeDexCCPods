//
//  TrainerController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import FirebaseAuth

class TrainerController {
    static var currentUser: User?
    
    static func addCapturedPokemon(_ pokemon: Pokemon, with completion: (Bool) -> Void) {
        var pokemon = pokemon
        pokemon.setTrainerID(trainerID: currentUser?.uid)
        
        PokemonController.shared.addCapturedPokemon(pokemon)
    }
}
