//
//  UpcomingTitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Felipe Vidal on 27/12/21.
//

import UIKit

class UpcomingTitleTableViewCell: UITableViewCell {
    
    static let identifier = "UpcomingTitleTableViewCell"
    
    let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "backdrop_image")
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .lightGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title3, weight: .bold)
        label.text = "Title name"
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .callout, weight: .regular)
        label.text = "Title name"
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        
        let symbolConfiguration = UIImage.SymbolConfiguration.init(font: .preferredFont(for: .title3, weight: .semibold))
        let image = UIImage(systemName: "play.circle", withConfiguration: symbolConfiguration)
        
        if #available(iOS 15.0, *) {
            var buttonConfiguration = UIButton.Configuration.tinted()
            buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            buttonConfiguration.image = image
            buttonConfiguration.baseForegroundColor = .white
            buttonConfiguration.baseBackgroundColor = .clear
            button.configuration = buttonConfiguration
        } else {
            button.setImage(image, for: .normal)
            button.tintColor = .white
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            button.backgroundColor = .clear
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        contentView.addSubview(backdropImageView)
        contentView.addSubview(loadingIndicator)
        contentView.addSubview(nameLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(overviewLabel)
        
        loadingIndicator.startAnimating()
        
        applyConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 9/16)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: backdropImageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: playButton.leadingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            overviewLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            playButton.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor),
            playButton.topAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
    }
    
    public func configure(with model: TitleViewModel) {
        guard let backdropPath = model.titleBackdropPath, let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)") else { return }
        backdropImageView.sd_setImage(with: backdropURL) { [weak self] _, _, _, _ in
            self?.loadingIndicator.stopAnimating()
        }
        
        nameLabel.text = model.titleName
        overviewLabel.text = model.titleOverview
    }

}

#if DEBUG
import SwiftUI

struct UpcomingTableViewCellPreviews: PreviewProvider {
    static var previews: some View {
        ContainerPreview()
            .previewLayout(.sizeThatFits)
    }
    
    struct ContainerPreview: UIViewRepresentable {
        typealias UIViewControllerType = UITableViewCell
        
        func makeUIView(context: Context) -> Self.UIViewControllerType {
            return UpcomingTitleTableViewCell()
        }
        
        func updateUIView(_ uiViewController: Self.UIViewControllerType, context: Context) {}
    }
}
#endif
