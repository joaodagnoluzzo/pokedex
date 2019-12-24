//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 24/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    
    var type: PokeTypeUrl?

    private var pokemonTableViewData = [PokeUrl]()
    
    let pokedexViewModel = PokedexViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let type = type else { return }
        self.title = type.name + " type pokemons"
        
        self.pokedexViewModel.retrievePokemonList(typeUrl: type.url) { (results) in
            switch results {
            case .success(let data):
                self.pokemonTableViewData = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonTableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "pokemonListCell", for: indexPath)
        cell.textLabel?.text = self.pokemonTableViewData[indexPath.row].name
        return cell
    }

}
