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
}

// Failable init for JSON parsing
extension Pokemon {
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

// Custom codable
extension Pokemon: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case topAbility
        case spriteURL
        case trainerID
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.topAbility, forKey: .topAbility)
        try container.encode(self.spriteURL, forKey: .spriteURL)
        try container.encode(self.trainerID, forKey: .trainerID)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(Int.self, forKey: .id)
        let topAbility = try container.decodeIfPresent(String.self, forKey: .topAbility)
        let spriteURL = try container.decodeIfPresent(String.self, forKey: .spriteURL)
        let trainerID = try container.decodeIfPresent(String.self, forKey: .trainerID)
        
        self.name = name
        self.id = id
        self.topAbility = topAbility
        self.spriteURL = spriteURL
        self.trainerID = trainerID
    }
}
