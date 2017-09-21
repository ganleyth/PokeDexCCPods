//
//  PokemonCaptureViewController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/19/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import UIKit
import GameKit

class PokemonCaptureViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var distanceSlider: UISlider!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokemonDistance: Int?
    var distanceAccuracy: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDistanceSlider()
        fetchRandomPokemon()
    }
    
    @IBAction func throwPokeballButtonTapped(_ sender: UIButton) {
        guard let pokemonDistance = pokemonDistance,
            let distanceAccuracy = distanceAccuracy else { return }
        
        let throwingDistance = Int(distanceSlider.value)
        
        let pokemonCaptured = abs(throwingDistance - pokemonDistance) <= distanceAccuracy
        
        if pokemonCaptured {
            
        }
        
        presentPokeballThrownAlert(pokemonCaptured: pokemonCaptured)
    }
    
    @IBAction func discardButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func fetchRandomPokemon() {
        PokemonController.shared.fetchRandomPokemon { (pokemon) in
            self.pokemon = pokemon
        }
    }
    
    func updateViews() {
        
        let pokemonName = pokemon?.name ?? "Unknown Pokemon"
        let pokemonNameCapitalized = pokemonName.capitalized
        
        let pokemonDistance = randomDistance(upTo: 100)
        self.pokemonDistance = pokemonDistance
        
        let distanceAccuracy = randomDistance(upTo: 3)
        self.distanceAccuracy = distanceAccuracy
        
        descriptionLabel.text = "The \(pokemonNameCapitalized) is \(pokemonDistance) away!"
        instructionLabel.text = "Try to aim your throw \(pokemonDistance) +/- \(distanceAccuracy) feet"
        
        if let spriteURLString = pokemon?.spriteURL,
            let spriteURL = URL(string: spriteURLString) {
            
            ImageController.fetchImage(atURL: spriteURL, with: { (spriteImage) in
                DispatchQueue.main.async {
                    self.spriteImageView.image = spriteImage
                }
            })
        }
    }
    
    func setupDistanceSlider() {
        distanceSlider.minimumValue = 0.0
        distanceSlider.maximumValue = 100.0
    }
    
    func randomDistance(upTo upperBound: Int) -> Int {
        let upperBoundZeroIndexed = upperBound - 1
        let randomSource = GKRandomSource.sharedRandom()
        let randomDistanceZeroIndexed = randomSource.nextInt(upperBound: upperBoundZeroIndexed)
        let randomDistanceOneIndexed = randomDistanceZeroIndexed + 1
        return randomDistanceOneIndexed
    }
    
    func presentPokeballThrownAlert(pokemonCaptured: Bool) {
        guard let pokemon = pokemon else { return }
        
        let title = pokemonCaptured ? "\(pokemon.name.capitalized) Caught!" : "You missed!"
        let message = pokemonCaptured ? "\(pokemon.name.capitalized) is now availabe in your captured Pokemon" : "Better luck next time"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { (_) in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}
