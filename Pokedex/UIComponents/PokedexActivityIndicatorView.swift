//
//  PokedexActivityIndicatorView.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 28/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class PokedexActivityIndicatorView: UIActivityIndicatorView {
    
    init() {
        super.init(style: .large)
        hidesWhenStopped = true
        backgroundColor = UIColor(hex: Constants.UI.Colors.white, alpha: 0.8)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupConstraints() {
        guard let container = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: container.centerXAnchor),
            centerYAnchor.constraint(equalTo: container.centerYAnchor),
            widthAnchor.constraint(equalTo: container.widthAnchor),
            heightAnchor.constraint(equalTo: container.heightAnchor)
        ])
    }
}
