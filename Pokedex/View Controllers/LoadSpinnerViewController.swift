//
//  LoadSpinnerViewController.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 27/12/19.
//  Adapted from: https://www.hackingwithswift.com/example-code/uikit/how-to-use-uiactivityindicatorview-to-show-a-spinner-when-work-is-happening
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class LoadSpinnerViewController: UIViewController {

    private var loadSpinner = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        self.view = UIView()
        
        self.view.backgroundColor = UIColor(hex: "#f0f0f0", alpha: 0.8)
        
        self.loadSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        self.loadSpinner.startAnimating()
        self.view.addSubview(self.loadSpinner)
        
        self.loadSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.loadSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
