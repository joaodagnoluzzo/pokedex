//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 26/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView?
    @IBOutlet weak var pokemonHeightLabel: UILabel?
    @IBOutlet weak var pokemonWeightLabel: UILabel?
    @IBOutlet weak var pokemonAbilitiesTextView: UITextView?
    @IBOutlet weak var pokemonShareButton: UIBarButtonItem?
    
    var pokemonUrl: PokeUrl?
    
    private let pokedexViewModel = PokedexViewModel()
    private var loadSpinnerView = LoadSpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(pokemonUrl: pokemonUrl)
        self.retrieveData(pokemonUrl: pokemonUrl)
    }
    
    private func setupLoadingScreen(){
        self.loadSpinnerView.view.frame = self.view.frame
        self.view.addSubview(self.loadSpinnerView.view)
        self.pokemonShareButton?.isEnabled = false
    }
    
    private func removeLoadingScreen(){
        DispatchQueue.main.async {
            self.loadSpinnerView.view.removeFromSuperview()
            self.loadSpinnerView.removeFromParent()
            self.pokemonShareButton?.isEnabled = true
        }
    }
    
    private func setTextViewStyle(){
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        guard let font = UIFont(name: "PokemonGB", size: 17) else { return }
        let attributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: font]
        guard let textView = self.pokemonAbilitiesTextView else { return }
        guard let currentText = self.pokemonAbilitiesTextView!.text else { return }
        textView.attributedText = NSAttributedString(string: currentText, attributes:attributes)
    }
    
    private func setTitle(pokemonUrl: PokeUrl?){
        guard let pokemonUrl = pokemonUrl else { return }
        self.title = pokemonUrl.name
    }
    
    private func retrieveData(pokemonUrl: PokeUrl?){
        guard let pokemonUrl = pokemonUrl else { return }
        self.setupLoadingScreen()
        self.pokedexViewModel.retrievePokemonDetails(pokemonUrl: pokemonUrl.url) { (results) in
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
            let errorMsg = UIAlertController(title: "Error", message: "Couldn't catch this \(self.title ?? "")", preferredStyle: .alert)
            errorMsg.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.removeLoadingScreen()
                self.popViewController()
            }))
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
    
    private func popViewController(){
        guard let navController = self.navigationController else { return }
        navController.popViewController(animated: true)
    }
    
    private func setupViews(pokemon: Pokemon){
        self.setPokemonImage(url: pokemon.sprites.frontDefault)
        DispatchQueue.main.async {
            self.setPokemonHeight(height: pokemon.height)
            self.setPokemonWeight(weight: pokemon.weight)
            self.setPokemonAbilities(abilities: pokemon.abilities)
            self.removeLoadingScreen()
        }
    }
    
    private func setPokemonImage(url: String){
        guard let url = URL(string: url) else { return }
        self.pokemonImageView?.load(url:url)
    }
    
    private func setPokemonHeight(height: Int){
            self.pokemonHeightLabel?.text = self.pokedexViewModel.formatPokemonHeight(height: height)
    }
    
    private func setPokemonWeight(weight: Int){
        self.pokemonWeightLabel?.text = self.pokedexViewModel.formatPokemonWeight(weight: weight)
    }
    
    private func setPokemonAbilities(abilities: [Abilities]){
            self.pokemonAbilitiesTextView?.text = self.pokedexViewModel.formatAbilities(abilities: abilities)
            self.setTextViewStyle()
    }
    
    @IBAction func sharePokemonInfo(_ sender: Any) {
        var shareInfo = ""
        
        shareInfo += "*\(self.title ?? "")*\n"
        shareInfo += "Weight: \(self.pokemonWeightLabel?.text ?? "")\n"
        shareInfo += "Height: \(self.pokemonHeightLabel?.text ?? "")\n"
        shareInfo += "Abilities:\n\(self.pokemonAbilitiesTextView?.text ?? "")"
        
        let shareViewController = UIActivityViewController(activityItems: [shareInfo], applicationActivities: [])
        shareViewController.excludedActivityTypes = [.airDrop, .addToReadingList, .assignToContact, .markupAsPDF, .saveToCameraRoll]
        self.present(shareViewController, animated: true, completion: nil)
    }
}
