//
//  UIAlertController+CustomInit.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 26/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

extension UIAlertController {
    convenience init(title: String, errorMessage: String, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, message: errorMessage, preferredStyle: .alert)
        self.addAction(UIAlertAction(title: Constants.Error.acceptLabel, style: .default, handler: handler))
    }
}
