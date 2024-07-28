//
//  PokeTypesTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class PokeTypeTableViewController: UIViewController {

    private var tableViewData = [PokeTypeUrl]()
    private let viewModel = PokeTypeViewModel()
    private var tableView = PokeTypeTableView()
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        tableView.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarTitleProperties()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Types"
        setupTableView()
        self.retrieveData()
    }
    
    private func setNavigationBarTitleProperties(){
        guard let navController = self.navigationController else { return }
        guard let font = UIFont(name: "PokemonSolidNormal", size: 25) else { return }
        guard let white = UIColor(named: "White") else { return }
        guard let black = UIColor(named: "Black") else { return }
        navController.navigationBar.titleTextAttributes = self.setupStrokeAttributes(font: font, strokeWidth: 4.0, insideColor: white, strokeColor: black)
    }
    
    private func retrieveData(){
        viewModel.retrievePokeTypes { (result) in
            switch result {
            case .success(let data):
                self.tableViewData = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                self.handleError()
            }
        }
    }
    
    private func handleError(){
        DispatchQueue.main.async {
            let errorMsg = UIAlertController(title: "Error", errorMessage: "PokeTypes not found! Check your Pokenet connection.")
            self.present(errorMsg, animated: true, completion: nil)
        }
    }
    
    public func setupStrokeAttributes(font: UIFont, strokeWidth: Float, insideColor: UIColor, strokeColor: UIColor) -> [NSAttributedString.Key: Any]{
        return [NSAttributedString.Key.strokeColor : strokeColor, NSAttributedString.Key.foregroundColor : insideColor, NSAttributedString.Key.strokeWidth : -strokeWidth, NSAttributedString.Key.font : font]
    }
}


extension PokeTypeTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier, for: indexPath) as? GenericTableViewCell else {
            return UITableViewCell()
        }
        
        let item = tableViewData[indexPath.row]
        cell.configure(with: item.name)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonTableViewController = PokemonTableViewController(type: self.tableViewData[indexPath.row])
        navigationController?.pushViewController(pokemonTableViewController, animated: true)
    }
}

extension PokeTypeTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
}
