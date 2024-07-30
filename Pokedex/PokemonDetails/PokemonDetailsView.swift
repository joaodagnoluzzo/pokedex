//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by João Pedro C. D'Agnoluzzo on 27/07/24.
//  Copyright © 2024 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit


class PokemonDetailsView: UIView {
    
    private var pokemonShareButton: UIBarButtonItem?
    private let imageView = UIImageView()
    private let infoLabel = UILabel()
    private let weightLabel = UILabel()
    private let weightValueLabel = UILabel()
    private let heightLabel = UILabel()
    private let heightValueLabel = UILabel()
    private let abilitiesLabel = UILabel()
    private let abilitiesTextView = UITextView()
    private let imageActivityIndicator = PokedexActivityIndicatorView()
    private var heightHStack = UIStackView()
    private var weightHStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
        imageActivityIndicator.startAnimating()
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
        imageActivityIndicator.stopAnimating()
    }
    
    func configure(_ height: String, _ weight: String, _ abilities: String) {
        weightValueLabel.text = weight
        heightValueLabel.text = height
        abilitiesTextView.text = abilities
        abilitiesTextView.customStyleAndFont(spacing: 20, size: 17)
    }
    
    private func setupSubviews() {
        setupImageView()
        addSubview(imageView)
        
        setupInfoLabel()
        addSubview(infoLabel)
        
        
        setupWeightLabel()
        setupWeightValueLabel()
        
        setupWeightHStack()
        addSubview(weightHStack)
        
        setupHeightLabel()
        setupHeightValueLabel()
        
        setupHeightHStack()
        addSubview(heightHStack)
                
        setupAbilitiesLabel()
        addSubview(abilitiesLabel)
        
        setupAbilitiesTextView()
        addSubview(abilitiesTextView)
    }
    
    private func setupImageView() {
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.addSubview(imageActivityIndicator)
        imageActivityIndicator.setupConstraints()
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupInfoLabel() {
        infoLabel.text = "Info"
        infoLabel.font = UIFont.customTitleFont(size: 24)
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupWeightHStack() {
        weightHStack = createHStack(weightLabel, weightValueLabel)
    }
    
    private func setupHeightHStack() {
        heightHStack = createHStack(heightLabel, heightValueLabel)
    }
    
    private func setupWeightLabel() {
        weightLabel.text = "Weight:"
        weightLabel.font = UIFont.customBodyFont(size: 16)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupWeightValueLabel() {
        weightValueLabel.text = "--.-- Kg"
        weightValueLabel.font = UIFont.customBodyFont(size: 16)
        weightValueLabel.textAlignment = .right
        weightValueLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHeightLabel() {
        heightLabel.text = "Height:"
        heightLabel.font = UIFont.customBodyFont(size: 16)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHeightValueLabel() {
        heightValueLabel.text = "--.-- m"
        heightValueLabel.font = UIFont.customBodyFont(size: 16)
        heightValueLabel.textAlignment = .right
        heightValueLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAbilitiesLabel() {
        abilitiesLabel.text = "Abilities"
        abilitiesLabel.font = UIFont.customTitleFont(size: 24)
        abilitiesLabel.textAlignment = .center
        abilitiesLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAbilitiesTextView() {
        abilitiesTextView.font = UIFont.systemFont(ofSize: 16)
        abilitiesTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createHStack(_ labelLeft: UILabel, _ labelRight: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(labelLeft)
        stackView.addArrangedSubview(labelRight)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func setupConstraints() {
        let titleHeight: CGFloat = 34
        let titleWidth: CGFloat = 120
        let margin: CGFloat = 32
        let stackHeight: CGFloat = 30
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: titleHeight),
            infoLabel.widthAnchor.constraint(equalToConstant: titleWidth),
            
            weightHStack.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 16),
            weightHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            weightHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            weightHStack.heightAnchor.constraint(equalToConstant: stackHeight),
            
            heightHStack.topAnchor.constraint(equalTo: weightHStack.bottomAnchor, constant: 8),
            heightHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            heightHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            heightHStack.heightAnchor.constraint(equalToConstant: stackHeight),

            abilitiesLabel.topAnchor.constraint(equalTo: heightHStack.bottomAnchor, constant: 32),
            abilitiesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            abilitiesLabel.heightAnchor.constraint(equalToConstant: titleHeight),
            abilitiesLabel.widthAnchor.constraint(equalToConstant: titleWidth),

            abilitiesTextView.topAnchor.constraint(equalTo: abilitiesLabel.bottomAnchor, constant: 16),
            abilitiesTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            abilitiesTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            abilitiesTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
}

extension UITextView {
    func customStyleAndFont(spacing: CGFloat, size: CGFloat){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        let font = UIFont.customBodyFont(size: size)
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: font]
        self.attributedText = NSAttributedString(string: self.text, attributes:attributes)
    }
}
