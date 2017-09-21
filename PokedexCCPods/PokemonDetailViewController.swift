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
        guard let pokemon = pokemon else { return }
        PokemonController.shared.setCapturedPokemonFree(pokemon: pokemon)
        presentPokemonSetFreeAlert()
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
    
    func presentPokemonSetFreeAlert() {
        let title = "Pokemon Set Free!"
        let message = "Tap OK to return to your remaining captured Pokemon"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
