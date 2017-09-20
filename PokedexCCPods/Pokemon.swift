//
//  Pokemon.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/20/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation

struct Pokemon {
    let name: String
    let id: Int
    let topAbility: String?
    let spriteURL: String?
    var spriteData: Data?
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[Constants.nameKey] as? String,
            let id = dictionary[Constants.idKey] as? Int else { return nil }
        
        self.name = name
        self.id = id
        
        let abilitiesArray = dictionary[Constants.abilitiesKey] as? [[String: Any]]
        let topAbilityDictionary = abilitiesArray?.first
        let topAbilityDeeperDictionary = topAbilityDictionary?[Constants.abilityKey] as? [String: String]
        let topAbility = topAbilityDeeperDictionary?[Constants.nameKey]
        
        let spritesDictionary = dictionary[Constants.spritesKey] as? [String: Any]
        let spriteURL = spritesDictionary?[Constants.frontDefaultKey] as? String
        
        self.topAbility = topAbility
        self.spriteURL = spriteURL
    }
}

extension Pokemon {
    mutating func setSpriteData(data: Data?) {
        self.spriteData = data
    }
}
