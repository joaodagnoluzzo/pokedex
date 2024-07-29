//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 26/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {
    
    var loadSpinner = PokedexActivityIndicatorView()
    let detailsView = PokemonDetailsView()
    private var viewModel: PokemonDetailsViewModel!
    
    override func loadView() {
        view = detailsView
    }
    
    init(pokemon: PokeUrl) {
        super.init(nibName: nil, bundle: nil)
        viewModel = PokemonDetailsViewModel(pokeUrl: pokemon)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        setRightNavigationBarButton()
        setupLoadingScreen()
        retrieveData()
        
    }
    
    private func setupLoadingScreen(){
        view.addSubview(loadSpinner)
        loadSpinner.setupConstraints()
    }
    
    private func setTitle(){
        self.title = viewModel.getPokemonName()
    }
    
    private func setRightNavigationBarButton() {
        let pokemonShareButton = UIBarButtonItem(
            image: UIImage.init(
                systemName: Constants.PokeDetails.shareIcon
            ),
            style: .plain,
            target: self,
            action: #selector(sharePokemonInfo)
        )
        navigationItem.rightBarButtonItem = pokemonShareButton
    }
    
    private func retrieveData(){
        loadSpinner.startAnimating()
        viewModel.retrievePokemonDetails { error in
            if error == nil {
                self.setupViews()
            } else {
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
                self.popViewController()
            }
            self.loadSpinner.stopAnimating()
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
    
    private func popViewController(){
        guard let navController = self.navigationController else { return }
        navController.popViewController(animated: true)
    }
    
    private func setupViews() {
        DispatchQueue.main.async {
            self.detailsView.configure(
                self.viewModel.getFormattedHeight(),
                self.viewModel.getFormattedWeight(),
                self.viewModel.getFormattedAbilities()
            )
            self.loadSpinner.stopAnimating()
        }
        
        self.setPokemonImage(url: viewModel.getImageUrl()) { [weak self] image in
            DispatchQueue.main.async {
                self?.detailsView.configure(with: image)
            }
        }
    }
    
    private func setPokemonImage(url: String, completionHandler: @escaping (UIImage) -> Void){
        self.viewModel.retrievePokemonImage(imageUrl: url, completion: { image in
            guard let image = image else {
                completionHandler(UIImage())
                return
            }
            completionHandler(image)
        })
    }
    
    @objc func sharePokemonInfo() {
        let shareInfo = viewModel.shareInfo()
        
        let shareViewController = UIActivityViewController(activityItems: [shareInfo], applicationActivities: [])
        shareViewController.excludedActivityTypes = [.airDrop, .addToReadingList, .assignToContact, .markupAsPDF, .saveToCameraRoll]
        self.present(shareViewController, animated: true, completion: nil)
    }
}
