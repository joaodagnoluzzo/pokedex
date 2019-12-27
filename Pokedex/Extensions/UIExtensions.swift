//
//  UIExtensions.swift
//  Pokedex
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 26/12/19.
//  Copyright © 2019 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL){
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}

extension UIColor {
    // Adapted from https://gist.github.com/arshad/de147c42d7b3063ef7bc
    convenience init(hex: String, alpha: Float){
        var resultingHex = hex
        
        if (resultingHex.hasPrefix("#")) {
            resultingHex.remove(at: resultingHex.startIndex)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: resultingHex).scanHexInt64(&rgbValue)
        
        self.init(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(alpha))
    }
    
    convenience init(hex: String){
        self.init(hex: hex, alpha: 1.0)
    }
}

extension UITableViewCell {
    func configureWithPokeballColors(){
        self.textLabel?.textColor = UIColor(hex: "#222224")
        self.backgroundColor = UIColor(hex: "#f0f0f0")
    }
    
    func configureWithPokemonFont(){
        self.textLabel?.font = UIFont(name: "PokemonGB", size: 17)
    }
}

extension UIActivityIndicatorView {
    func setupTableViewIndicator(view: UIView){
        self.hidesWhenStopped = true
        self.style = .large
        self.center = view.center
        view.addSubview(self)
    }
}

extension UIAlertController {
    convenience init(errorMessage: String){
        self.init(title: "Error", message: errorMessage, preferredStyle: .alert)
        self.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
}
