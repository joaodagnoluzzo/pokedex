//
//  PokeTypesTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokeTypesTableViewController: UITableViewController {

    private var tableViewData = [PokeTypeUrl]()
    private let viewModel = PokeTypesViewModel()
    private var loadSpinner = UIActivityIndicatorView(style: .large)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarTitleProperties()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSpinner.setupTableViewIndicator(view: self.view)
        self.retrieveData()
    }
    
    private func setNavigationBarTitleProperties(){
        guard let navController = self.navigationController else { return }
        guard let font = UIFont(name: "PokemonSolidNormal", size: 25) else { return }
        navController.navigationBar.titleTextAttributes = self.setupStrokeAttributes(font: font, strokeWidth: 4.0, insideColor: UIColor(hex: "#f0f0f0"), strokeColor: UIColor(hex: "#222224"))
    }
    
    private func retrieveData(){
        self.loadSpinner.startAnimating()
        viewModel.retrievePokeTypes { (results) in
            switch results {
            case .success(let data):
                self.tableViewData = data
                DispatchQueue.main.async {
                    self.loadSpinner.stopAnimating()
                    self.tableView.reloadData()
                }
            case .failure(_):
                self.handleError()
            }
        }
    }
    
    private func handleError(){
        DispatchQueue.main.async {
            self.loadSpinner.stopAnimating()
            let errorMsg = UIAlertController(title: "Error", errorMessage: "PokeTypes not found! Check your Pokenet connection.")
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50.0)
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeTypeCell", for: indexPath)
        cell.textLabel?.text = self.tableViewData[indexPath.row].name
        cell.configureWithPokeballColors()
        cell.configureWithPokemonFont()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pokemonListSegue"){
            guard let destinationViewController = segue.destination as? PokemonTableViewController else { return }
            guard let index = self.tableView.indexPathForSelectedRow?.row else { return }
            destinationViewController.type = self.tableViewData[index]
        }
    }
    
    public func setupStrokeAttributes(font: UIFont, strokeWidth: Float, insideColor: UIColor, strokeColor: UIColor) -> [NSAttributedString.Key: Any]{
        return [NSAttributedString.Key.strokeColor : strokeColor, NSAttributedString.Key.foregroundColor : insideColor, NSAttributedString.Key.strokeWidth : -strokeWidth, NSAttributedString.Key.font : font]
    }
}
