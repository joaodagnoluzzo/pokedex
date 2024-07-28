//
//  PokemonTableView.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 27/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class PokemonTableView: UITableView {
    
    private var loadSpinner = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
//        loadSpinner.setupTableViewIndicator(view: self)
//        addSubview(loadSpinner)
//        
//        NSLayoutConstraint.activate([
//            loadSpinner.centerYAnchor.constraint(equalTo: centerYAnchor),
//            loadSpinner.centerXAnchor.constraint(equalTo: centerXAnchor)
//        ])
    }
    
//    func startLoading() {
//        loadSpinner.startAnimating()
//    }
//
//    func stopLoading() {
//        loadSpinner.stopAnimating()
//    }
}
