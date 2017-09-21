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
    var trainerID: String?

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

// Accessors
extension Pokemon {
    mutating func setSpriteData(data: Data?) {
        self.spriteData = data
    }
    
    mutating func setTrainerID(trainerID: String?) {
        self.trainerID = trainerID
    }
}

// Firebase dictionary translations
extension Pokemon {
    var dictionaryRepresentation: [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary[Constants.nameKey] = self.name
        dictionary[Constants.idKey] = self.id
        dictionary[Constants.abilityKey] = self.topAbility
        dictionary[Constants.frontDefaultKey] = self.spriteURL
        dictionary[Constants.trainerIDKey] = self.trainerID
        
        return dictionary
    }
    
    init?(firebaseDictionary: [String: Any]) {
        guard let name = firebaseDictionary[Constants.nameKey] as? String,
            let id = firebaseDictionary[Constants.idKey] as? Int else { return nil }
        
        self.name = name
        self.id = id
        
        let topAbility = firebaseDictionary[Constants.abilityKey] as? String
        let spriteURL = firebaseDictionary[Constants.frontDefaultKey] as? String
        let trainerID = firebaseDictionary[Constants.trainerIDKey] as? String

        self.topAbility = topAbility
        self.spriteURL = spriteURL
        self.trainerID = trainerID        
    }
}
