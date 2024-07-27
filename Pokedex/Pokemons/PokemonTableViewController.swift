//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 24/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokemonTableViewController: UIViewController {

    private var tableView = PokemonTableView()
    

    
    var type: PokeTypeUrl?
    private var pokemonTableViewData = [PokeUrl]()
    private let viewModel = PokemonViewModel()
    private var loadSpinner = UIActivityIndicatorView(style: .large)
    
    
    init(type: PokeTypeUrl? = PokeTypeUrl(name: "Fire", url: "https://pokeapi.co/api/v2/type/1/")) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.setTitle(pokeType: type)
//        self.loadSpinner.setupTableViewIndicator(view: self.view)
        self.retrieveData(pokeType: type)
    }
    
    private func setTitle(pokeType: PokeTypeUrl?){
        guard let type = type else { return }
        self.title = type.name
    }
    
    private func retrieveData(pokeType: PokeTypeUrl?){
        guard let type = type else { return }
        self.loadSpinner.startAnimating()
        self.viewModel.retrievePokemonList(typeUrl: type.url) { [weak self] (results) in
            switch results {
            case .success(let data):
                self?.pokemonTableViewData = data
                DispatchQueue.main.async {
                    self?.loadSpinner.stopAnimating()
                    self?.tableView.reloadData()
                    self?.handleEmptyList()
                }
            case .failure(_):
                self?.handleError()
            }
        }
    }
    
    private func handleEmptyList(){
        if self.pokemonTableViewData.count > 0 { return }
        let emptyMsg = UIAlertController(title: "Oops", errorMessage: "Sounds like pokémon of this type are yet to be discovered!\nGotta catch 'em all!")
        self.present(emptyMsg, animated: true, completion: nil)
    }
    
    private func handleError(){
        DispatchQueue.main.async {
            self.loadSpinner.stopAnimating()
            let errorMsg = UIAlertController(title: "Error", errorMessage: "It seems we lost our pokémons! Check your Pokenet connection.")
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pokemonDetailSegue"){
            guard let destinationViewController = segue.destination as? PokemonDetailsViewController else { return }
            guard let index = self.tableView.indexPathForSelectedRow?.row else { return }
            destinationViewController.pokemonUrl = self.pokemonTableViewData[index]
        }
    }

}


extension PokemonTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier, for: indexPath) as? GenericTableViewCell else {
            return UITableViewCell()
        }
        
        let item = pokemonTableViewData[indexPath.row]
        cell.textLabel?.text = item.name

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonTableViewData.count
    }
}

extension PokemonTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50.0)
    }
}
