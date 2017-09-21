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
        updateViews()
    }
    
    @IBAction func releaseButtonTapped(_ sender: UIButton) {
    }

    func updateViews() {
        guard isViewLoaded else { return }
        
        nameLabel.text = pokemon?.name.capitalized
        idLabel.text = pokemon == nil ? "Unknown" : "\(pokemon!.id)"
        abilityLabel.text = pokemon?.topAbility?.capitalized
        
        if let spriteData = pokemon?.spriteData {
            spriteImageView.image = UIImage(data: spriteData)
        }
    }
}
