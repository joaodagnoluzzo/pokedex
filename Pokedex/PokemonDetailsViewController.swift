//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 26/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonImageView: UIImageView?
    @IBOutlet weak var pokemonHeightLabel: UILabel?
    @IBOutlet weak var pokemonWeightLabel: UILabel?
    @IBOutlet weak var pokemonAbilitiesTextView: UITextView?
    
    var pokemonUrl: PokeUrl?
    
    private let pokedexViewModel = PokedexViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(pokemonUrl: pokemonUrl)
        self.retrieveData(pokemonUrl: pokemonUrl)
    }
    
    private func setTitle(pokemonUrl: PokeUrl?){
        guard let pokemonUrl = pokemonUrl else { return }
        self.title = pokemonUrl.name
    }
    
    private func retrieveData(pokemonUrl: PokeUrl?){
        guard let pokemonUrl = pokemonUrl else { return }
        self.pokedexViewModel.retrievePokemonDetails(pokemonUrl: pokemonUrl.url) { (results) in
            switch results {
            case .success(let pokemon):
                self.setupViews(pokemon: pokemon)
                
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func setupViews(pokemon: Pokemon){
        self.setPokemonImage(url: pokemon.sprites.frontDefault)
        self.setPokemonHeight(height: pokemon.height)
        self.setPokemonWeight(weight: pokemon.weight)
        self.setPokemonAbilities(abilities: pokemon.abilities)
    }
    
    private func setPokemonImage(url: String){
        guard let url = URL(string: url) else { return }
        self.pokemonImageView?.load(url:url)
    }
    
    private func setPokemonHeight(height: Int){
        DispatchQueue.main.async {
            self.pokemonHeightLabel?.text = self.pokedexViewModel.formatPokemonHeight(height: height)
        }
    }
    
    private func setPokemonWeight(weight: Int){
        DispatchQueue.main.async {
            self.pokemonWeightLabel?.text = self.pokedexViewModel.formatPokemonWeight(weight: weight)
        }
    }
    
    private func setPokemonAbilities(abilities: [Abilities]){
        DispatchQueue.main.async {
            self.pokemonAbilitiesTextView?.text = self.pokedexViewModel.formatAbilities(abilities: abilities)
        }
    }
}
