//
//  MainCoordinator.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 03/08/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let pokeTypeVC = PokeTypeTableViewController()
        pokeTypeVC.delegate = self
        navigationController.pushViewController(pokeTypeVC, animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension ApplicationCoordinator: PokeTybeTableViewControllerDelegate {
    func didSelectType(item: PokeTypeUrl) {
        let pokemonVC = PokemonTableViewController(type: item)
        pokemonVC.delegate = self
        navigationController.pushViewController(pokemonVC, animated: true)
    }
}

extension ApplicationCoordinator: PokemonTableViewControllerDelegate {
    func didSelectPokemon(item: PokeUrl) {
        let detailsVC = PokemonDetailsViewController(pokemon: item)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
