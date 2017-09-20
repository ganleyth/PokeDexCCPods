//
//  PokemonController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import GameKit

class PokemonController {
    
    static let shared = PokemonController()
    
    func fetchRandomPokemon(with completion: @escaping (Pokemon?) -> Void) {
        let randomPokemonID = GKRandomSource.sharedRandom().nextInt(upperBound: 153) - 1
        
        guard let pokemonSearchURL = Constants.baseURL?.appendingPathComponent("\(randomPokemonID)") else { completion(nil); return }
        
        NetworkClient.performDataTaskWith(baseURL: pokemonSearchURL, httpMethod: .get) { (data, error) in
            var pokemon: Pokemon? = nil
            defer {
                DispatchQueue.main.async {
                    completion(pokemon)
                }
            }
            
            if let error = error { NSLog("Error fetching pokemon: \(error.localizedDescription)"); return }
            guard let data = data else { NSLog("Data returned from pokemon fetch is nil"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else {
                NSLog("Could not serialize returned pokemon data")
                return
            }
            
            pokemon = Pokemon(dictionary: jsonDictionary)
        }
    }
}
