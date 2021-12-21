//
//  HeroHeaderView.swift
//  Netflix Clone
//
//  Created by Felipe Vidal on 21/12/21.
//

import UIKit

class HeroHeaderView: UIView {
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16)
            configuration.baseBackgroundColor = .white
            configuration.title = "Play"
            configuration.baseForegroundColor = .black
            button.configuration = configuration
        } else {
            button.backgroundColor = UIColor.white
            button.setTitle("Play", for: .normal)
            button.setTitleColor(.black, for: .normal)
        }
        
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16)
            configuration.title = "Download"
            configuration.baseForegroundColor = .white
            button.configuration = configuration
        } else {
            button.backgroundColor = UIColor.white
            button.setTitle("Download", for: .normal)
            button.setTitleColor(.black, for: .normal)
        }
        
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonsStackView: UIStackView!

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImageView)
        
        addGradient()
        
        addButtonsStack()
        applyConstraints()
    }
    
    private func addButtonsStack() {
        buttonsStackView = UIStackView(arrangedSubviews: [playButton, downloadButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 16
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonsStackView)
    }
    
    private func applyConstraints() {
        let heroImageViewConstraints = [
            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let playButtonConstraints = [
            playButton.widthAnchor.constraint(equalTo: downloadButton.widthAnchor, multiplier: 1)
        ]
        
        let buttonsStackViewConstraints = [
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(heroImageViewConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(buttonsStackViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
