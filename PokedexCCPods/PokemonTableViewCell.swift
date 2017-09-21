//
//  PokemonTableViewCell.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/21/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
}

extension PokemonTableViewCell {
    func updateCell(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        
        if let spriteData = pokemon.spriteData {
            spriteImageView.image = UIImage(data: spriteData)
        }
    }
}
