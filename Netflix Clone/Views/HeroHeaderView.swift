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
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
            configuration.baseBackgroundColor = .white
            configuration.title = "Play"
            configuration.baseForegroundColor = .black
            button.configuration = configuration
        } else {
            button.backgroundColor = UIColor.white
            button.setTitle("Play", for: .normal)
            button.setTitleColor(.black, for: .normal)
        }
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
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
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonsStackView: UIStackView!

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomGradientContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        layer.locations = [0.5, 1]
        return layer
    }()
    
    private let topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        layer.locations = [0, 1]
        return layer
    }()
    
    private func addGradient() {
        
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 150)
        layer.addSublayer(topGradientLayer)
        
        addSubview(bottomGradientContainerView)
        
        bottomGradientContainerView.layer.addSublayer(bottomGradientLayer)
        
        bottomGradientLayer.frame = self.bounds
        bottomGradientLayer.frame.origin.y = -bounds.height
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
        
        let gradientContainerViewConstraints = [
            bottomGradientContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomGradientContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomGradientContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        
        NSLayoutConstraint.activate(heroImageViewConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(buttonsStackViewConstraints)
        NSLayoutConstraint.activate(gradientContainerViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: Title) {
        guard let posterPath = model.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
        
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
}

#if DEBUG
import SwiftUI
struct HeroHeaderViewPreviews: PreviewProvider {
    static var previews: some View {
        ContainerPreview()
            .previewLayout(.fixed(width: 375, height: 450))
    }
    
    struct ContainerPreview: UIViewRepresentable {
        typealias UIViewControllerType = UIView
        
        func makeUIView(context: Context) -> some UIView {
            return HeroHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 450))
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }
}
#endif
