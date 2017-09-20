//
//  PokemonDetailViewController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/19/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomPokemon()
    }
    
    @IBAction func releaseButtonTapped(_ sender: UIButton) {
    }
    
    func fetchRandomPokemon() {
        PokemonController.shared.fetchRandomPokemon { (pokemon) in
            self.pokemon = pokemon
        }
    }
    
    func updateViews() {
        nameLabel.text = pokemon?.name
        if let id = pokemon?.id { idLabel.text = "\(id)" }
        abilityLabel.text = pokemon?.topAbility
        
        if let spriteURLString = pokemon?.spriteURL,
            let spriteURL = URL(string: spriteURLString) {
            
            ImageController.fetchImage(atURL: spriteURL, with: { (spriteImage) in
                self.spriteImageView = UIImageView(image: spriteImage)
            })
        }
    }
}
