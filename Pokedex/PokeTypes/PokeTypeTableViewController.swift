//
//  PokeTypesTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokeTypeTableViewController: UIViewController {

    private let viewModel = PokeTypeViewModel()
    private var tableView = PokedexGenericTableView()
    private let loadingSpinner = PokedexActivityIndicatorView()
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.setupConstraints()
        
        tableView.register(PokedexGenericTableViewCell.self, forCellReuseIdentifier: PokedexGenericTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupLoadingSpinner() {
        view.addSubview(loadingSpinner)
        loadingSpinner.setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.clearRowSelection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.PokeTypes.title
        setupTableView()
        setupLoadingSpinner()
        
        self.retrieveData()
    }
    
    private func retrieveData(){
        loadingSpinner.startAnimating()
        
        
        viewModel.retrievePokeTypes { [weak self] error in
            if error == nil {
                self?.reloadList()
            } else {
                self?.handleError()
            }
        }
    }
    
    private func reloadList() {
        DispatchQueue.main.async {
            self.loadingSpinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private func handleError(){
        DispatchQueue.main.async {
            self.loadingSpinner.stopAnimating()
            let errorMsg = UIAlertController(title: Constants.Error.title, errorMessage: Constants.Error.pokeTypesNotFound)
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
}

extension PokeTypeTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokeTypeCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokedexGenericTableViewCell.identifier, for: indexPath) as? PokedexGenericTableViewCell else {
            return UITableViewCell()
        }
        let item = viewModel.pokeTypeAt(index: indexPath.row)
        cell.configure(with: item.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.pokeTypeAt(index: indexPath.row)
        let pokemonTableViewController = PokemonTableViewController(type: item)
        navigationController?.pushViewController(pokemonTableViewController, animated: true)
    }
    
}

extension PokeTypeTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.rowSize
    }
    
}
