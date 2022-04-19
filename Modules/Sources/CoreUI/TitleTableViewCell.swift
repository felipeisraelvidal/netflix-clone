import UIKit
import Core

public class TitleTableViewCell: UITableViewCell {
    
    public static let identifier = "TitleTableViewCell"
    
    private lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .lightGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title3, weight: .bold)
        label.text = "Title name"
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .callout, weight: .regular)
        label.text = "Overview"
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playButton: UIButton = {
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
    
    private lazy var selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        selectedBackgroundView = selectionView
        
        contentView.addSubview(backdropImageView)
        contentView.addSubview(loadingIndicator)
        contentView.addSubview(nameLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(overviewLabel)
        
        loadingIndicator.startAnimating()
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
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
    
    // MARK: - Public methods
    
    public func configure(with model: Title, imageRequest: ImageRequestProtocol) {
        nameLabel.text = model.safeName
        overviewLabel.text = model.overview
        
        loadingIndicator.startAnimating()
        if let path = model.backdropPath, let url = URL(string: "\(imageRequest.baseURL)/\(path)") {
            backdropImageView.sd_setImage(with: url) { [weak self] _, _, _, _ in
                self?.loadingIndicator.stopAnimating()
            }
        }
    }
    
}
