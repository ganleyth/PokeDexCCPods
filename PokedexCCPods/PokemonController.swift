//
//  PokemonController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import GameKit
import FirebaseDatabase

class PokemonController {
    
    static let shared = PokemonController()
    let databaseRef = Database.database().reference()
    var capturedPokemon: [Pokemon] = []
    
    func fetchRandomPokemon(with completion: @escaping (Pokemon?) -> Void) {
        let randomPokemonID = GKRandomSource.sharedRandom().nextInt(upperBound: 153) - 1
        
        guard let pokemonSearchURL = Constants.baseURL?.appendingPathComponent("\(randomPokemonID)") else { completion(nil); return }
        
        NetworkClient.performDataTaskWith(baseURL: pokemonSearchURL, httpMethod: .get) { (response) in
            var pokemon: Pokemon? = nil
            defer {
                DispatchQueue.main.async {
                    completion(pokemon)
                }
            }
            
            guard let response = response else { completion(nil); return }
            
            guard let jsonDictionary = response.value as? [String: Any] else { completion(nil); return }

            pokemon = Pokemon(dictionary: jsonDictionary)
        }
    }
    
    func addCapturedPokemon(_ pokemon: Pokemon) {
        guard let trainerID = TrainerController.currentUser?.uid else { return }
        
        capturedPokemon.append(pokemon)
        let pokemonJSONData = pokemon.dictionaryRepresentation
        
        databaseRef.child(trainerID).child(Constants.pokemonKey).child(pokemon.name).setValue(pokemonJSONData)
    }
}
