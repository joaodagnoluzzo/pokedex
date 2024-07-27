//
//  GenericTableViewCell.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 27/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit


class GenericTableViewCell: UITableViewCell {
    
    static let identifier = "genericTableViewCellIdentifier"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.customBodyFont(size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(label)
        
        setupLabel()
        configureStyling()
    }
    
    func configure(with text: String) {
        label.text = text
    }
    
    private func setupLabel() {
        let offset: CGFloat = 10
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
    }
    
    func configureStyling() {
        self.textLabel?.textColor = UIColor(hex: "#222224")
        self.backgroundColor = UIColor(hex: "#f0f0f0")
    }
}
