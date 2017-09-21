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
    var sortedCapturedPokemon: [Pokemon] {
        return capturedPokemon.sorted { $0.name < $1.name }
    }
    
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
    
    func fetchCapturedPokemon() {
        guard let trainerID = TrainerController.currentUser?.uid else { return }
        
        databaseRef.child(trainerID).child(Constants.pokemonKey).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let jsonDictionary = snapshot.value as? [String: [String: Any]] else {
                NSLog("Could not properly fetch captured pokemon")
                return
            }
            
            for (_, value) in jsonDictionary {
                if var pokemon = Pokemon(firebaseDictionary: value),
                    let spriteURLString = pokemon.spriteURL,
                    let spriteURL = URL(string: spriteURLString) {
                    
                    ImageController.fetchImage(atURL: spriteURL, with: { (image) in
                        if let image = image,
                            let imageData = UIImagePNGRepresentation(image) {
                            
                            pokemon.setSpriteData(data: imageData)
                            self.capturedPokemon.append(pokemon)
                            
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: Constants.capturedPokemonUpdatedNotification, object: self)
                            }
                        }
                    })
                }
            }
        }) { (error) in
            NSLog(error.localizedDescription)
        }
    }
}
