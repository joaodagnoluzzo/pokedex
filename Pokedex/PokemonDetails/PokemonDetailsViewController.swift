//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 26/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {
    
    let detailsView = PokemonDetailsView()
    var pokemonUrl: PokeUrl?
    
    private let viewModel = PokemonDetailsViewModel()
    
    override func loadView() {
        view = detailsView
    }
    
    init(pokemon: PokeUrl?) {
        super.init(nibName: nil, bundle: nil)
        self.pokemonUrl = pokemon
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(pokemonUrl: pokemonUrl)
        setRightNavigationBarButton()
        retrieveData(pokemonUrl: pokemonUrl)
        
    }
    
    private func setupLoadingScreen(){
//        self.loadSpinnerView.view.frame = self.view.frame
//        self.view.addSubview(self.loadSpinnerView.view)
//        self.pokemonShareButton?.isEnabled = false
    }
    
    private func removeLoadingScreen(){
        DispatchQueue.main.async {
            
//            self.pokemonShareButton?.isEnabled = true
        }
    }
    
    private func setTitle(pokemonUrl: PokeUrl?){
        guard let pokemonUrl = pokemonUrl else { return }
        self.title = pokemonUrl.name
    }
    
    private func setRightNavigationBarButton() {
        let pokemonShareButton = UIBarButtonItem(image: UIImage.init(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(sharePokemonInfo))
        navigationItem.rightBarButtonItem = pokemonShareButton
    }
    
    private func retrieveData(pokemonUrl: PokeUrl?){
        guard let pokemonUrl = pokemonUrl else { self.handleError(); return }
//        self.setupLoadingScreen()
        self.viewModel.retrievePokemonDetails(pokemonUrl: pokemonUrl.url) { (results) in
            switch results {
            case .success(let pokemon):
                self.setupViews(pokemon: pokemon)
            case .failure(_):
                self.handleError()
            }
        }
    }
    
    private func handleError(){
        DispatchQueue.main.async {
            let errorMsg = UIAlertController(
                title: Constants.Error.title,
                errorMessage: Constants.Error.pokemonEscaped.replacingOccurrences(of: "{pokemon}", with: (self.title ?? "Pokémon")))
            { _ in
//                self.removeLoadingScreen()
                self.popViewController()
            }
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
    
    private func popViewController(){
        guard let navController = self.navigationController else { return }
        navController.popViewController(animated: true)
    }
    
    private func setupViews(pokemon: PokemonModel){
        
        DispatchQueue.main.async {
            let formattedHeight = pokemon.height.toFormattedHeight()
            let formattedWeight = pokemon.weight.toFormattedWeight()
            let formattedAbilities = self.formatAbilities(pokemon.abilities)
            
            self.detailsView.configure(formattedHeight, formattedWeight, formattedAbilities)
            self.removeLoadingScreen()
        }
        
        self.setPokemonImage(url: pokemon.sprites.frontDefault) { [weak self] image in
            DispatchQueue.main.async {
                self?.detailsView.configure(with: image)
            }
        }
    }
    
    private func setPokemonImage(url: String, completionHandler: @escaping (UIImage) -> Void){
        self.viewModel.retrievePokemonImage(imageUrl: url, completion: { image in
            guard let image = image else { return }
            completionHandler(image)
        })
    }
    
    private func formatAbilities(_ abilities: [Abilities]) -> String {
        var formattedText = ""
        for item in abilities {
            let formattedAbilityName = item.ability.name.toTitleCase()
            formattedText += "\(formattedAbilityName)\n"
        }
        return formattedText
    }
    
    @objc func sharePokemonInfo() {
        
        let shareInfo = viewModel.shareInfo()
        
        let shareViewController = UIActivityViewController(activityItems: [shareInfo], applicationActivities: [])
        shareViewController.excludedActivityTypes = [.airDrop, .addToReadingList, .assignToContact, .markupAsPDF, .saveToCameraRoll]
        self.present(shareViewController, animated: true, completion: nil)
    }
}
