//
//  Constants.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation

struct Constants {
    
    // Pokemon JSON keys
    static let nameKey = "name"
    static let idKey = "id"
    static let abilitiesKey = "abilities"
    static let abilityKey = "ability"
    static let spritesKey = "sprites"
    static let frontDefaultKey = "front_default"
    
    // Firebase specific keys
    static let spriteImageKey = "spriteImage"
    static let trainerIDKey = "trainerID"
    static let pokemonKey = "pokemon"
    
    // URL
    static let baseURL = URL(string: "https://www.pokeapi.co/api/v2/pokemon")
}
