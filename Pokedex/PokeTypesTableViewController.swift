//
//  PokeTypesTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class PokeTypesTableViewController: UITableViewController {

    
    private var tableViewData = [PokeTypeUrl]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pokedexViewModel = PokedexViewModel()
        pokedexViewModel.retrievePokeTypes { (results) in
            switch results {
            case .success(let data):
//                print(data)
                self.tableViewData = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeTypeCell", for: indexPath)
        
        cell.textLabel?.text = self.tableViewData[indexPath.row].name
        
        return cell
    }
}
