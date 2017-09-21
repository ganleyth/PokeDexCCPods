//
//  PokemonListViewController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/19/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let dataProvider: PokemonListDataProvider = PokemonListDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func fetchPokemonButtonTapped(_ sender: UIButton) {
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
