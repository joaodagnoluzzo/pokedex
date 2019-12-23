//
//  PokeTypesTableViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 23/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class PokeTypesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pokedexViewModel = PokedexViewModel()
        
        pokedexViewModel.fetchTypes()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
   
}
