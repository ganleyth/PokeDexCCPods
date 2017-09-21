//
//  PokemonListDataProvider.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/21/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import Foundation
import UIKit

class PokemonListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonController.shared.sortedCapturedPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = PokemonController.shared.sortedCapturedPokemon[indexPath.row]
        cell.updateCell(with: pokemon)
        return cell
    }
}
