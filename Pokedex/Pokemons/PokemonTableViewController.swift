//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 24/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokemonTableViewController: UIViewController {

    private var tableView = PokedexGenericTableView()
    private let viewModel = PokemonViewModel()
    private let loadSpinner = PokedexActivityIndicatorView()
    
    init(type: PokeTypeUrl?) {
        super.init(nibName: nil, bundle: nil)
        viewModel.pokeType = type
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.setupConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PokedexGenericTableViewCell.self, forCellReuseIdentifier: PokedexGenericTableViewCell.identifier)
    }
    
    func setupLoadSpinner() {
        view.addSubview(loadSpinner)
        loadSpinner.setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.clearRowSelection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(pokeType: viewModel.pokeType)
        setupTableView()
        setupLoadSpinner()
        retrieveData()
    }
    
    private func setTitle(pokeType: PokeTypeUrl?){
        guard let pokeType = pokeType else { return }
        title = pokeType.name
    }
    
    private func retrieveData(){
        loadSpinner.startAnimating()
        viewModel.retrievePokemonList() { [weak self] error in
            if error != nil {
                self?.handleError()
            } else {
                self?.handleSuccess()
            }
        }
    }
    
    private func handleSuccess() {
        DispatchQueue.main.async {
            self.loadSpinner.stopAnimating()
            self.tableView.reloadData()
            self.handleEmptyList()
        }
    }
    
    private func handleEmptyList(){
        if viewModel.pokemonCount() > 0 { return }
        let emptyMsg = UIAlertController(
            title: Constants.Error.title,
            errorMessage: Constants.Error.emptyPokemonList) {
                [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        self.present(emptyMsg, animated: true, completion: nil)
    }
    
    private func handleError(){
        DispatchQueue.main.async {
            self.loadSpinner.stopAnimating()
            let errorMsg = UIAlertController(
                title: Constants.Error.title,
                errorMessage: Constants.Error.pokeTypesNotFound) {
                    [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
}


extension PokemonTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokedexGenericTableViewCell.identifier, for: indexPath) as? PokedexGenericTableViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.pokemonAt(index: indexPath.row)
        cell.configure(with: item.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.pokemonAt(index: indexPath.row)
        let detailsViewController = PokemonDetailsViewController(pokemon: item)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonCount()
    }
}

extension PokemonTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.rowSize
    }
}
