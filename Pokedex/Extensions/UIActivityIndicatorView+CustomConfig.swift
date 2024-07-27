//
//  UIActivityIndicatorView+CustomConfig.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func setupTableViewIndicator(view: UIView){
        self.hidesWhenStopped = true
        self.style = .large
        self.center = view.center
        view.addSubview(self)
    }
}
