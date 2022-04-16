import UIKit
import Core

class TopInfoTableViewCell: UITableViewCell {
    
    static let identifier = "TopInfoTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        label.text = "Title name"
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let watchButton: UIButton = {
        
        let backgroundColor: UIColor = .white
        let foregroundColor: UIColor = .black
        let button = UIButton(type: .system)
        
        let symbolConfiguration = UIImage.SymbolConfiguration(font: .preferredFont(for: .footnote, weight: .bold))
        let image = UIImage(systemName: "play.fill", withConfiguration: symbolConfiguration)
        
        let title = "Watch"
        let titleFont: UIFont = .preferredFont(for: .body, weight: .semibold)
        
        let verticalInsets: CGFloat = 8
        let horizontalInsets: CGFloat = 0
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = backgroundColor
            configuration.baseForegroundColor = foregroundColor
            configuration.contentInsets = NSDirectionalEdgeInsets(top: verticalInsets, leading: horizontalInsets, bottom: verticalInsets, trailing: horizontalInsets)
            
            configuration.imagePlacement = .leading
            configuration.imagePadding = 12
            configuration.image = image
            
            var attributedTitle = AttributedString(title)
            attributedTitle.font = titleFont
            configuration.attributedTitle = attributedTitle
            
            button.configuration = configuration
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = titleFont
            
            button.setTitle(title, for: .normal)
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            
            button.contentEdgeInsets = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        
        let backgroundColor: UIColor = .systemGray
        let foregroundColor: UIColor = .white
        
        let symbolConfiguration = UIImage.SymbolConfiguration(font: .preferredFont(for: .footnote, weight: .bold))
        let image = UIImage(systemName: "arrow.down.to.line", withConfiguration: symbolConfiguration)
        
        let title = "Download"
        let titleFont: UIFont = .preferredFont(for: .body, weight: .semibold)
        
        let verticalInsets: CGFloat = 8
        let horizontalInsets: CGFloat = 0
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.gray()
            configuration.baseBackgroundColor = backgroundColor
            configuration.baseForegroundColor = foregroundColor
            configuration.contentInsets = NSDirectionalEdgeInsets(top: verticalInsets, leading: horizontalInsets, bottom: verticalInsets, trailing: horizontalInsets)
            
            configuration.imagePlacement = .leading
            configuration.imagePadding = 12
            configuration.image = image
            
            var attributedTitle = AttributedString(title)
            attributedTitle.font = titleFont
            configuration.attributedTitle = attributedTitle
            
            button.configuration = configuration
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = titleFont
            
            button.setTitle(title, for: .normal)
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            
            button.contentEdgeInsets = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        contentView.addSubview(watchButton)
        NSLayoutConstraint.activate([
            watchButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            watchButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            watchButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
        
        contentView.addSubview(downloadButton)
        NSLayoutConstraint.activate([
            downloadButton.topAnchor.constraint(equalTo: watchButton.bottomAnchor, constant: 8),
            downloadButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            downloadButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            downloadButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
    }
    
    // MARK: - Public methods
    
    func configure(with model: Title) {
        nameLabel.text = model.safeName
    }
    
}
